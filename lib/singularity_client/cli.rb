# encoding: utf-8

require 'thor'
require 'singularity_client'

module SingularityClient
  # Handles all command line interface logic
  class CLI < Thor
    attr_reader :config_hash

    def initialize(*args)
      super
      @cli_options = options
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
      run(:config)
    end

    desc 'add REPO_NAME PROJECT_NAME', 'Add a github repository to singularity'
    long_desc 'This will add both pull requests, and pushes, to singularity'
    method_option :github_organization, aliases: '-o', type: :string,
      desc: 'Override the default github organization'
    def add(repo, project)
      run(:add, repo, project, 'pull_request')
      run(:add, repo, project, 'push')
    end

    desc 'addPull REPO_NAME PROJECT_NAME', 'Add repo pulls to singularity'
    method_option :github_organization, aliases: '-o', type: :string,
      desc: 'Override the default github organization'
    def add(repo, project)
      run(:add, repo, project, 'pull_request')
    end

    desc 'addPush REPO_NAME PROJECT_NAME', 'Add repo pushes to singularity'
    method_option :github_organization, aliases: '-o', type: :string,
      desc: 'Override the default github organization'
    def add(repo, project)
      run(:add, repo, project, 'push')
    end

    desc 'comment REPO_NAME PR_NUM COMMENT', 'Write comment to a pull request'
    method_option :github_organization, aliases: '-o', type: :string,
      desc: 'Override the default github organization'
    def comment(repo, pr, comment)
      run(:comment, repo, pr, comment)
    end

    private

    def run(action, *args)
      config = SingularityClient::Config.new(@cli_options)
      SingularityClient::API.send(action, config, *args)
    end
  end
end
