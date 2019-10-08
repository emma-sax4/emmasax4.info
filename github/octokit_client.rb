require 'yaml'
require 'octokit'

class OctokitClient
  GITHUB_CONFIG_FILE = ".automation/config.yml"

  def client
    Octokit::Client.new(access_token: github_token)
  end

  private def github_token
    YAML.load_file(github_config_file_path)[:github_token]
  end

  private def github_config_file_path
    Dir.pwd.scan(/\A\/[\w]*\/[\w]*\//).first << GITHUB_CONFIG_FILE
  end
end
