require 'httparty'
require 'json'
require 'pp'

module SingularityClient
  class API

    def self.config(config)
      endpoint = 'config'
      request = "#{config.base_uri}/#{endpoint}"

      puts "DEBUG: sending get request #{request}" if config.debug

      response = HTTParty.get(request)

      if response.code == 200
        pp JSON.parse(response.body)
      else
        raise "ERROR #{response.code} #{response.message}"
      end
    end

    def self.add(config, repo, project)
      endpoint = 'config/pull_request'
      request = "#{config.base_uri}/#{endpoint}"
      post_data = {
        :organization => config.organization,
        :repo => repo,
        :project => project
      }

      puts "DEBUG: sending post request to #{request}" if config.debug
      puts "DEBUG: with post_data #{post_data}" if config.debug

      response = HTTParty.post(request, :body => post_data)

      if (response.code == 200)
        puts "success!"
      else
        raise "ERROR #{response.code} #{response.message}"
      end
    end
  end
end
