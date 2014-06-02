# encoding: utf-8

require 'json'
require 'pp'

require 'singularity_client/request'

module SingularityClient
  # Handles the singularity api
  class API
    def self.config(config)
      endpoint = 'config'

      request = SingularityClient::Request.new(config)
      response = request.get(endpoint)

      pp(JSON.parse(response.body))
    end

    def self.add(config, repo, project)
      endpoint = 'config/pull_request'
      post_data = {
        organization: config.organization,
        repo: repo,
        project: project
      }

      request = SingularityClient::Request.new(config)
      request.post(endpoint, post_data)

      puts('success!')
    end

    def self.comment(config, repo, pr, comment)
      # if pr is not a number, pr.to_i will return 0
      # zero is not a valid pull-request identifier
      fail('ERROR invalid pull-request provided') if pr.to_i == 0

      endpoint = 'comment'
      post_data = {
        organization: config.organization,
        repo: repo,
        pull_request: pr,
        message: comment
      }

      request = SingularityClient::Request.new(config)
      request.post(endpoint, post_data)

      puts('success!')
    end
  end
end
