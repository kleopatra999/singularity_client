# encoding: utf-8

require 'spec_helper'

describe SingularityClient::Request do

  let(:config_obj) do
    double('config',
           base_uri: 'http://mergeatron.dev-be-aws.net:3306',
           debug: false,
           organization: 'some_org'
    )
  end

  let(:request_obj) { SingularityClient::Request.new(config_obj) }

  describe '#error' do

    describe 'when a request receives a non 200 OK response' do
      it 'it throws an exception (get request)' do
        VCR.use_cassette('error-get') do
          expect { request_obj.get('/doesnt-exist') }
            .to raise_error(RuntimeError, 'ERROR 404 Not Found')
        end
      end

      it 'it throws an exception (post request)' do
        VCR.use_cassette('error-post') do
          expect { request_obj.post('/doesnt-exist') }
            .to raise_error(RuntimeError, 'ERROR 404 Not Found')
        end
      end
    end
  end
end
