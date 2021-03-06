# encoding: utf-8

require 'spec_helper'

describe SingularityClient::Config do
  describe '.initialize' do
    it 'raises an exception if validation fails' do
      expect(File).to receive(:exist?)
                      .at_least(:once)
                      .with(/.*\/.singularity.yml/)
                      .and_return(false)

      error = <<-ERR.gsub(/^[\s\t]*/, '').gsub(/[\s\t]*\n/, ' ').strip
        singularity_port not defined. Please see
        https://github.com/behance/singularity_client#configuration
        for configuration options
      ERR
      expect do
        SingularityClient::Config.new('singularity_url' => 'test.url')
      end .to raise_error(RuntimeError, error)
    end
  end

  describe '@options' do
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
          'config' => './.singularity.yml'
        )

        expect(config.options).to eql(
          'singularity_url' => 'http://mergeatron.dev-be-aws.net',
          'singularity_port' => '3306',
          'github_organization' => 'BehanceOps',
          'config' => './.singularity.yml'
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

  let(:config) { SingularityClient::Config.new({}) }

  describe '#base_uri' do
    it 'returns base_uri' do
      expect(config.base_uri).to eql('http://mergeatron.dev-be-aws.net:3306')
    end
  end

  describe '#organization' do
    it 'returns organization from file' do
      expect(config.organization).to eql('BehanceOps')
    end

    it 'returns command line organization' do
      config = SingularityClient::Config.new('github_organization' => 'Test')

      expect(config.organization).to eql('Test')
    end
  end

  describe '#debug' do
    it 'returns false by default' do
      expect(config.debug).to eql(false)
    end

    it 'returns true when set' do
      config = SingularityClient::Config.new('debug' => true)

      expect(config.debug).to eql(true)
    end
  end

end
