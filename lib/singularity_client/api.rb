require 'httparty'
require 'json'
require 'pp'

module SingularityClient
  class API

    def self.config(config)
      endpoint = 'config'
      request = "#{config.base_uri}/#{endpoint}"

      response = HTTParty.get(request)

      if response.code == 200
        pp JSON.parse(response.body)
      else
        raise "ERROR #{response.code} #{response.message}"
      end

    end

    def self.add(config)
      endpoint = 'config/pull_request'
      request = "#{config.base_uri}/#{endpoint}"
      post_data = {
        organization: 'BehanceOps',
        repo: 'beamusebouched',
        project: 'test-beamusebouched'
      }

      response = HTTParty.post(request, post_data)

      pp JSON.parse(response.body)
    end
  end
end
