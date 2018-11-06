require 'rubygems'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# require_relative 'support/controller_helpers'
require 'simplecov'
SimpleCov.start 'rails'
require 'devise'
require 'rspec/rails'
require 'pry'
require 'capybara/rspec'

ENV['OT-SECRET-KEY'] = "secret.key:///message_encryptor;g5HCCdORMQRfRlgcJpFZ_YMkZZM5EPh2xjaHx31x9iqpuMuDvlTKdlP48GXSBbpSSnJOFT3JYgDEYUbK5GRQDQ"

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Rails.application.routes.url_helpers
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include Devise::TestHelpers, type: :helper
  
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    Watir.default_timeout = 5
  end

  config.before :each do
    DatabaseCleaner.clean
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end
  
  config.after do
    DatabaseCleaner.clean
  end

  Warden.test_mode!

  config.after do
    Warden.test_reset!
  end

  # config.before(:each) do
  #   Sidekiq::Worker.clear_all
  # end
  config.infer_spec_type_from_file_location!
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.expose_dsl_globally = false
end
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.javascript_driver = :chrome
Capybara.server_port = 4000
