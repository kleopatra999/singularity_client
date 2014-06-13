# encoding: utf-8

require 'spec_helper'

describe SingularityClient::ConfigLoader do
  describe '.load_from_file' do
    filepath = 'test/path'
    config = { key: 'value' }

    describe 'when filepath is provided' do
      it 'loads the provided file' do
        expect(SingularityClient::ConfigLoader)
          .to_not receive(:find_config_file)

        expect(YAML).to receive(:load_file)
                        .with(filepath)
                        .and_return(config)

        expect(
          SingularityClient::ConfigLoader.load_from_file(filepath, false)
        ).to eq(config)
      end
    end

    describe 'when filepath is not provided' do
      describe 'and a .singularity.yml exists' do
        it 'loads .singularity.yml' do
          expect(SingularityClient::ConfigLoader.load_from_file).to eq(
            'singularity_url' => 'http://mergeatron.dev-be-aws.net',
            'singularity_port' => '3306',
            'github_organization' => 'BehanceOps'
          )
        end
      end

      describe 'and no singularity.yml exists' do
        it 'returns an empty hash' do
          expect(File).to receive(:exist?)
                          .at_least(:once)
                          .with(/.*\/.singularity.yml/)
                          .and_return(false)

          expect(SingularityClient::ConfigLoader.load_from_file).to eq({})
        end
      end
    end
  end
end
