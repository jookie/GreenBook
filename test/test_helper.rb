ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

DatabaseCleaner.strategy = :truncation

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end
