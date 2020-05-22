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
      :port           => 587,
      :address        => smtp.eu.mailgun.org,
      :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
      :password       => ENV['MAILGUN_SMTP_PASSWORD'],
      :domain         => 'preserve.pt',
      :authentication => :plain,
    }

    ActionMailer::Base.delivery_method = :smtp
  end
end
