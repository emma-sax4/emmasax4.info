require_relative './octokit_client.rb'

class PullRequest
  attr_accessor :pr_title

  REPOSITORY = "emma-sax4/emma-sax4.github.io"

  def initialize(pr_title)
    @pr_title = pr_title
  end

  def create_pull_request
    begin
      octokit_client.create_pull_request(REPOSITORY, "master", branch_name, @pr_title)
    rescue Octokit::UnprocessableEntity => e
      puts "Could not create pull request:"
      if e.message.include?("pull request already exists")
        puts "  A pull request already exists for this branch"
      else
        puts e.message
      end
    end
  end

  private def branch_name
    branches = `git branch`
    return branches.scan(/\*\s([\S]*)/).first.first
  end

  private def octokit_client
    @octokit_client ||= OctokitClient.new.client
  end
end

PullRequest.new(ARGV.join(" ")).create_pull_request
