# encoding: utf-8

require 'yaml'
require 'pathname'

module SingularityClient
  # Wrapper around the config object
  class Config
    DOTFILE = '.singularity.yml'

    attr_accessor :options

    def initialize(inputs)
      config_file = inputs['config'] || find_config_file('.')
      @options = load_from_file(config_file).merge(inputs)

      puts "DEBUG: Using configuration from #{config_file}" if debug
      puts "DEBUG: Current configuration: #{@options}" if debug
    end

    def base_uri
      "#{@options['singularity_url']}:#{@options['singularity_port']}"
    end

    def organization
      @options['github_organization']
    end

    def debug
      @options.key?('debug')
    end

    private

    def find_config_file(dir)
      Pathname.new(File.expand_path(dir)).ascend do |path|
        file = File.join(path.to_s, DOTFILE)
        return file if File.exist?(file)
      end

      fail 'Could not find .singularity.yml'
    end

    def load_from_file(file)
      fail "ERROR: #{file} does not exist" unless File.exists?(file)

      YAML.load_file(file)
    end
  end
end
