# encoding: UTF-8
if ENV['DEBUGMAIL_USER'].present?
  ActionMailer::Base.smtp_settings = {
        user_name: ENV['DEBUGMAIL_USER'],
        password: ENV['DEBUGMAIL_PASSWORD'],
        address: 'debugmail.io',
        port: 25,
        authentication: :plain,
        enable_starttls_auto: true
  }

else
  Mailjet.configure do |config|
      config.api_key = ENV["MAILJET_API_KEY"]
      config.secret_key = ENV["MAILJET_SECRET_KEY"]
      config.api_version = "v3.1"
  end
end
ActionMailer::Base.delivery_method ||= :smtp
