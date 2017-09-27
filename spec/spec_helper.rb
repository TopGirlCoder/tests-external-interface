require 'capybara/rspec'
require 'selenium-webdriver'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.configure do |config|
  config.run_server = false
  config.default_max_wait_time = 10 # seconds
  config.default_driver = :selenium_chrome
  config.app_host = 'http://pai-test.herokuapp.com'
end

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
 
