# encoding: UTF-8
if Rails.env.production?
  if ENV['DEBUGMAIL_USER'].present?
    ActionMailer::Base.smtp_settings = {
          user_name: ENV['DEBUGMAIL_USER'],
          password: ENV['DEBUGMAIL_PASSWORD'],
          address: 'debugmail.io',
          port: 25,
          authentication: :plain,
          enable_starttls_auto: true
    }
    ActionMailer::Base.delivery_method = :smtp

  else
    ActionMailer::Base.smtp_settings = {
          user_name: ENV['SENDGRID_USER'],
          password: ENV['SENDGRID_PASSWORD'],
          address: 'smtp.sendgrid.net',
          port: 465,
          authentication: :plain,
          enable_starttls_auto: true
    }

    ActionMailer::Base.delivery_method = :smtp
  end
end
