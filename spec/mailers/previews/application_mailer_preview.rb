# frozen_string_literal: true
class ApplicationMailerPreview < ActionMailer::Preview

  def seller_signup
    ApplicationMailer.seller_signup(Seller.first.id)
  end

  def seller_signup_notify_internal
    ApplicationMailer.seller_signup_notify_internal(Seller.unscoped.first.id)
  end

  def voucher_email
    ApplicationMailer.voucher_email(Voucher.first.id)
  end

  def seller_voucher_email
    ApplicationMailer.seller_voucher_email(Voucher.first.id)
  end
end
