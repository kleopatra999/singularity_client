# encoding: utf-8

require 'yaml'
require 'pathname'

module SingularityClient
  # Wrapper around the config object
  class ConfigLoader
    DOTFILE = '.singularity.yml'

    def self.load_from_file(file = false, debug = false)
      # If file is defined don't look for one, else find one
      file = find_config_file('.', debug) unless file

      # If no config file passed in, and none found, return empty hash
      file ? YAML.load_file(file) : {}
    end

    def self.find_config_file(dir, debug)
      Pathname.new(File.expand_path(dir)).ascend do |path|
        file = File.join(path.to_s, DOTFILE)
        if File.exist?(file)
          puts "DEBUG: Using configuration from #{file}" if debug
          return file
        end
      end

      puts 'DEBUG: Could not find .singularity.yml' if debug
    end
  end
end
