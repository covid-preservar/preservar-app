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
  # TODO
end
ActionMailer::Base.delivery_method ||= :smtp
