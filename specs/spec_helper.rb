require 'rubygems'
require 'bundler/setup'
require 'rspec'

RSpec.configure do |config|
  config.mock_framework = :mocha
end
