require 'capybara/rspec'

RSpec.configure do |config|
  # ...
  config.include(MailerMacros)
  config.before(:each) { reset_email }
end