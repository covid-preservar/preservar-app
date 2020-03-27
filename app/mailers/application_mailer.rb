# frozen_string_literal: true
class ApplicationMailer < ActionMailer::Base
  default from: 'Preserve <info@preserve.pt>'
  layout 'mailer'

  def seller_signup(seller)
    @seller = seller
    mail to: seller.seller_user.email, subject: 'Bem vindo ao Preserve!'
  end

  def seller_signup_notify_internal(seller)
    @seller = seller
    mail to: ENV['EUPAGO_EMAIL'], cc:'info@preserve.pt', subject: '[PRESERVE] Novo Registo'
  end

  def voucher_email(voucher)
    @voucher = voucher
    mail to: @voucher.email, subject: "O seu voucher Preserve.pt"
  end
end
