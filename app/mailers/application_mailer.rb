# frozen_string_literal: true
class ApplicationMailer < ActionMailer::Base
  default from: 'Preserve <info@preserve.pt>'
  layout 'mailer'

  def seller_signup(seller)
    @seller = seller
    mail to: 'pedro@codecreations.tech', subject: 'Bem vindo ao Preserve!'
  end

  def foo
    mail to: 'pedro@codecreations.tech', subject: test
  end

end
