require_relative './octokit_client.rb'

class PullRequest
  attr_accessor :pr_title

  def initialize(pr_title)
    @pr_title = pr_title
  end

  def create_pull_request
    begin
      pr = octokit_client.create_pull_request(repository, "master", branch_name, @pr_title)
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

  private def repository
    # Get the repository by looking in the remote URLs for the full repository name
    remotes = `git remote -v`
    return remotes.scan(/\S[\s]*[\S]+.com[\S]{1}([\S]*).git/).first.first
  end

  private def branch_name
    # Get the current branch by looking in the list of branches for the *
    branches = `git branch`
    return branches.scan(/\*\s([\S]*)/).first.first
  end

  private def octokit_client
    @octokit_client ||= OctokitClient.new.client
  end
end

PullRequest.new(ARGV.join(" ")).create_pull_request
