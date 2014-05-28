# encoding: utf-8

require 'spec_helper'

describe SingularityClient::API do

  let(:config_obj) do
    double('config',
           base_uri: 'test.net',
           debug: false,
           organization: 'some_org'
    )
  end

  let(:http_response) do
    double('http_response',
           code: 200,
           body: '{"repo": "test"}'
    )
  end

  let(:bad_response) do
    double('bad_response',
           code: 404,
           message: 'Some error'
    )
  end

  describe '.config' do
    subject(:config) { SingularityClient::API.config(config_obj) }

    describe 'when it receives a succesful response' do
      it 'it parses and displays the config' do
        HTTParty.should_receive(:get)
                .with('test.net/config')
                .and_return(http_response)

        expect(config).to eql('repo' => 'test')
      end
    end

    describe 'when it receives a bad response' do
      it 'raises an exception' do
        HTTParty.should_receive(:get)
                .with('test.net/config')
                .and_return(bad_response)

        expect { config }.to raise_error(RuntimeError, 'ERROR 404 Some error')
      end
    end
  end

  describe '.add' do
    subject(:add) do
      SingularityClient::API.add(config_obj, 'test_repo', 'test_project')
    end

    options = {
      body: {
        organization: 'some_org',
        repo: 'test_repo',
        project: 'test_project'
      }
    }

    describe 'when it receives a succesful response' do
      it 'it returns success!' do
        HTTParty.should_receive(:post)
                .with('test.net/config/pull_request', options)
                .and_return(http_response)

        STDOUT.should_receive(:puts).with('success!')
        add
      end
    end

    describe 'when it receives a bad response' do
      it 'raises an exception' do
        HTTParty.should_receive(:post)
                .with('test.net/config/pull_request', options)
                .and_return(bad_response)

        expect { add }.to raise_error(RuntimeError, 'ERROR 404 Some error')
      end
    end
  end
end