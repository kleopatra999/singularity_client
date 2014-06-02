# encoding: utf-8

require 'thor'
require 'singularity_client'

module SingularityClient
  # Handles all command line interface logic
  class CLI < Thor
    attr_reader :config_hash

    def initialize(*args)
      super
      @config_hash = SingularityClient::Config.new(options)
    end

    # rubocop:disable AlignHash
    class_option :config, aliases: '-c', type: :string,
      desc: 'Specify path to a .singularity.yml file'
    class_option :singularity_url, type: :string,
      desc: 'Override the default singularity url'
    class_option :singularity_port, type: :string,
      desc: 'Override the default singularity port'
    class_option :debug, aliases: '-d', type: :boolean,
      desc: 'Turn on debug mode'

    desc 'config', 'Get the current singularity config object'
    def config
      SingularityClient::API.config(config_hash)
    end

    desc 'add REPO_NAME PROJECT_NAME', 'Add a github repository to singularity'
    method_option :github_organization, aliases: '-o', type: :string,
      desc: 'Override the default github organization'
    def add(repo, project)
      SingularityClient::API.add(config_hash, repo, project)
    end

    desc 'comment REPO_NAME PR_NUM COMMENT', 'Write comment to a pull request'
    method_option :github_organization, aliases: '-o', type: :string,
      desc: 'Override the default github organization'
    def comment(repo, pr, comment)
      SingularityClient::API.comment(config_hash, repo, pr, comment)
    end
  end
end
