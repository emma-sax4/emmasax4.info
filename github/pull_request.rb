require_relative './octokit_client.rb'

class PullRequest
  attr_accessor :pr_title, :pr_number

  def initialize(title_or_number)
    if title_or_number.to_i > 0
      @pr_number = title_or_number.to_i
    else
      @pr_title = title_or_number
    end
  end

  def create_pull_request
    begin
      pr = octokit_client.create_pull_request(repository_from_local, "master", branch_from_local, @pr_title)
      puts "Pull request successfully created: #{pr.html_url}"
    rescue Octokit::UnprocessableEntity => e
      puts "Could not create pull request:"
      if e.message.include?("pull request already exists")
        puts "  A pull request already exists for this branch"
      elsif e.message.include?("No commits between master and")
        puts "  No commits have been pushed to GitHub"
      else
        puts e.message
      end
    end
  end

  def merge_pull_request
    begin
      merge = octokit_client.merge_pull_request(repository_from_local, @pr_number, commit_message)
      puts "Pull request successfully merged: #{merge.sha}"
    rescue Octokit::UnprocessableEntity => e
      puts "Could not merge pull request:"
      puts e.message
    end
  end

  private def repository_from_local
    # Get the repository by looking in the remote URLs for the full repository name
    remotes = `git remote -v`
    return remotes.scan(/\S[\s]*[\S]+.com[\S]{1}([\S]*).git/).first.first
  end

  private def branch_from_local
    # Get the current branch by looking in the list of branches for the *
    branches = `git branch`
    return branches.scan(/\*\s([\S]*)/).first.first
  end

  private def branch_from_pull_request
    octokit_client.pull_request(repository_from_local, @pr_number).head.ref
  end

  private def commit_message
    "Merge pull request ##{@pr_number} from #{github_username}/#{branch_from_pull_request}"
  end

  private def octokit_client
    @octokit_client ||= client_object.client
  end

  private def github_username
    @github_username ||= client_object.github_username
  end

  private def client_object
    @client_object ||= OctokitClient.new
  end
end

pr = PullRequest.new(ARGV[1])
action = ARGV[0].to_sym

if action == :create
  pr.create_pull_request
elsif action == :merge
  pr.merge_pull_request
end
