# frozen_string_literal: true
class ApplicationMailerPreview < ActionMailer::Preview

  def seller_signup
    ApplicationMailer.seller_signup(Seller.first)
  end

  def seller_signup_notify_internal
    ApplicationMailer.seller_signup_notify_internal(Seller.first)
  end

  def voucher_email
    ApplicationMailer.voucher_email(Voucher.first)
  end
end
