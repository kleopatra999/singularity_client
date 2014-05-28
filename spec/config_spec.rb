# encoding: utf-8

require 'spec_helper'

describe SingularityClient::Config do
  describe 'options' do
    describe 'merged correctly' do
      it 'when no inputs' do
        config = SingularityClient::Config.new({})

        expect(config.options).to eql(
          'singularity_url' => 'http://mergeatron.dev-be-aws.net',
          'singularity_port' => '3306',
          'github_organization' => 'BehanceOps'
        )
      end

      it 'when provided a config path' do
        config = SingularityClient::Config.new(
          'config' => '../.singularity.yml'
        )

        expect(config.options).to eql(
          'singularity_url' => 'http://mergeatron.net',
          'singularity_port' => '3306',
          'github_organization' => 'BehanceOps',
          'config' => '../.singularity.yml'
        )
      end

      it 'when provided a singularity url' do
        config = SingularityClient::Config.new(
          'singularity_url' => 'random.com'
        )

        expect(config.options).to eql(
          'singularity_url' => 'random.com',
          'singularity_port' => '3306',
          'github_organization' => 'BehanceOps'
        )
      end

      it 'when provided a singularity port' do
        config = SingularityClient::Config.new(
          'singularity_port' => '1111'
        )

        expect(config.options).to eql(
          'singularity_url' => 'http://mergeatron.dev-be-aws.net',
          'singularity_port' => '1111',
          'github_organization' => 'BehanceOps'
        )
      end
    end
  end
end
