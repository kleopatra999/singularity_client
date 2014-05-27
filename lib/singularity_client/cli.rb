require 'thor'
require 'singularity_client'

module SingularityClient
  class CLI < Thor

    attr_reader :config_hash

    def initialize(*args)
      super
      @config_hash = SingularityClient::Config.new
    end

    desc "config", "Get the current singularity config object"
    def config
      SingularityClient::API.config(config_hash)
    end

    desc "add", "Get the current singularity config object"
    def add
      SingularityClient::API.add(config_hash)
    end
  end
end
