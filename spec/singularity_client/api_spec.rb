# encoding: utf-8

require 'spec_helper'

describe SingularityClient::API do

  let(:config_obj) do
    double('config',
           base_uri: 'http://mergeatron.dev-be-aws.net:3306',
           debug: false,
           organization: 'some_org'
    )
  end

  describe '.config' do
    subject(:config) { SingularityClient::API.config(config_obj) }

    describe 'when it receives a succesful response' do
      it 'it parses and displays the config' do
        expected_response = {
          'github' => {
            'ci_user' => 'bejudged',
            'repositories' => %w(aws bevarnish)
          },
          'jenkins' => {
            'has_global_trigger_token' => true,
            'projects' => [{
              'name' => 'branch-cookbook-aws',
              'repo' => 'aws',
              'has_trigger_token' => true
            }, {
              'name' => 'branch-cookbook-bevarnish',
              'repo' => 'bevarnish',
              'has_trigger_token' => false
            }],
            'push_projects' => []
          }
        }

        VCR.use_cassette('config') do
          expect(config).to eq(expected_response)
        end
      end
    end
  end

  describe '.add' do
    subject(:add) do
      SingularityClient::API.add(config_obj, 'test_repo', 'test_project')
    end

    describe 'when it receives a succesful response' do
      it 'it returns success!' do
        VCR.use_cassette('add') do
          expect(STDOUT).to receive(:puts).with('success!')
          add
        end
      end
    end
  end

  describe '.comment' do
    subject(:comment) do
      comment = 'This is some test comment'
      SingularityClient::API.comment(config_obj, 'test_repo', '12', comment)
    end

    describe 'when it receives a succesful response' do
      it 'it returns success!' do
        VCR.use_cassette('comment') do
          expect(STDOUT).to receive(:puts).with('success!')
          comment
        end
      end
    end
  end
end
