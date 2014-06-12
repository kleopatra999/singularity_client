# encoding: utf-8

require 'yaml'
require 'pathname'

module SingularityClient
  # Wrapper around the config object
  class Config
    attr_accessor :options

    def initialize(inputs = {})
      @options = ConfigLoader.load_from_file(inputs['config'], inputs['debug'])
      @options = @options.merge(inputs)

      puts "DEBUG: Current configuration: #{@options}" if debug

      validate_config
    end

    def base_uri
      "#{@options['singularity_url']}:#{@options['singularity_port']}"
    end

    def organization
      @options['github_organization']
    end

    def debug
      @options.key? 'debug'
    end

    private

    def validate_config
      required_fields = %w(
        singularity_url
        singularity_port
      )

      required_fields.all? do |field|
        if @options.key? field
          true
        else
          fail <<-ERR.gsub(/^[\s\t]*/, '').gsub(/[\s\t]*\n/, ' ').strip
            #{field} not defined. Please see
            https://github.com/behance/singularity_client#configuration
            for configuration options
          ERR
        end
      end
    end
  end
end
