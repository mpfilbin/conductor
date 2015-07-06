require_relative '../specs/helpers/spec_helpers'
require 'rspec/support/spec'

RSpec.configure do |config|
  config.mock_with :rspec
  config.include Conductor::Rspec::Helpers

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end
end
