require 'yaml'

module SingularityClient
  class Config
    FILENAME = '.singularity.yml'

    attr_reader :options

    def initialize
      @config_file = default_config_file
      @options = load_from_file
    end

    def default_config_file
      File.join(Dir.pwd, '.singularity.yml')
    end

    def load_from_file
      unless File.exists?(@config_file)
        raise "Could not find .singularity.yml file"
      end

      puts "Using configuration from #{@config_file}"
      hash = YAML.load_file(@config_file)
    end

    def base_uri
      "#{options['SINGULARITY_URL']}:#{options['SINGULARITY_PORT']}"
    end

  end
end
