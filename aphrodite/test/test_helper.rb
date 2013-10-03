ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require 'minitest/rails'
require "minitest-spec-context"
require 'minitest/focus'
require 'minitest/colorize'
require 'mocha/setup'
Dir["#{Rails.root}/test/support/*.rb"].sort.each { |file| require file }

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  class << self
    alias :context :describe
  end

  def setup
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
    Document.tire.index.delete
    @routes = Rails.application.routes
  end

  def teardown
    # Add code that need to be executed after each test
  end
end

class ActionController::TestCase
  include Rails.application.routes.url_helpers
  include Devise::TestHelpers
  include Requests::JsonHelpers

  before do
    DatabaseCleaner.clean
  end

  def json
    @json ||= JSON.parse(response.body)
  end
end
