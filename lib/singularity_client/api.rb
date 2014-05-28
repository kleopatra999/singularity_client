# encoding: utf-8

require 'httparty'
require 'json'
require 'pp'

module SingularityClient
  # Handles the singularity api
  class API
    def self.config(config)
      endpoint = 'config'
      request = "#{config.base_uri}/#{endpoint}"

      puts "DEBUG: sending get request #{request}" if config.debug

      response = HTTParty.get(request)

      response.code == 200 ? pp(JSON.parse(response.body)) : error(response)
    end

    def self.add(config, repo, project)
      endpoint = 'config/pull_request'
      request = "#{config.base_uri}/#{endpoint}"

      puts "DEBUG: sending post request to #{request}" if config.debug
      puts "DEBUG: with post_data #{post_data}" if config.debug

      response = HTTParty.post(request, body: {
        organization: config.organization,
        repo: repo,
        project: project
      })

      response.code == 200 ? puts('success!') : error(response)
    end

    private

    def self.error(response)
      fail("ERROR #{response.code} #{response.message}")
    end
  end
end
