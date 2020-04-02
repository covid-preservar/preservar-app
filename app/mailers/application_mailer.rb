# frozen_string_literal: true
class ApplicationMailer < ActionMailer::Base
  default from: 'Preserve <info@preserve.pt>'
  layout 'mailer'

  def seller_signup(seller)
    @seller = seller
    mail to: @seller.seller_user.email, subject:'Confirmação de registo no Preserve'
  end

  def seller_signup_notify_internal(seller)
    @seller = seller
    mail to:ENV['EUPAGO_EMAIL'], cc:'eupago@preserve.pt', subject:'[tech4covid19] Novo Registo'
  end

  def voucher_email(voucher_id)
    @voucher = Voucher.find(voucher_id)
    mail to:@voucher.email, subject: 'Parabéns pelo apoio! Aqui está o seu voucher.'
  end

  def seller_voucher_email(voucher_id)
    @voucher = Voucher.find(voucher_id)
    mail to: @voucher.place.seller.seller_user.email, subject: "TO-DO"
  end
end
