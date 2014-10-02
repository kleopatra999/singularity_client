# encoding: utf-8

require 'httparty'

module SingularityClient
  # Wrapper around HTTParty requests
  class Request
    include HTTParty

    def initialize(config)
      @base_uri = config.base_uri
      @debug = config.debug
    end

    def get(endpoint, query = {})
      request = "#{@base_uri}/#{endpoint}"
      puts "DEBUG: sending get request #{request}" if @debug

      response = self.class.get(request, query)

      response.code == 200 ? response : error(response)
    end

    def post(endpoint, data = {})
      request = "#{@base_uri}/#{endpoint}"
      puts "DEBUG: sending post request to #{request}" if @debug
      puts "DEBUG: with post_data #{data}" if @debug

      response = self.class.post(request, body: data)

      response.code == 200 ? response : error(response)
    end

    def delete(endpoint, data = {})
      request = "#{@base_uri}/#{endpoint}"
      puts "DEBUG: sending delete request to #{request}" if @debug
      puts "DEBUG: with data #{data}" if @debug

      response = self.class.delete(request, body: data)

      response.code == 200 ? response : error(response)
    end

    private

    def error(response)
      fail("ERROR #{response.code} #{response.message}")
    end
  end
end
