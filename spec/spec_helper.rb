# encoding: utf-8

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter '/spec/'
  end
end

require 'singularity_client'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before do
    IO.any_instance.stub(:puts)
  end
end
