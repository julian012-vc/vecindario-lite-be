# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :address => ENV['SMTP_ADDRESS'],
  :authentication => :plain,
  :domain => ENV['SMTP_DOMAIN'],
  :enable_starttls_auto => true,
  :password => ENV['SMTP_API_KEY'],
  :port => 587,
  :user_name => ENV['SMTP_USER_NAME']
}
