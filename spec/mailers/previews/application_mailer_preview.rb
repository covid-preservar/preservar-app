# frozen_string_literal: true
class ApplicationMailerPreview < ActionMailer::Preview

  def seller_signup
    ApplicationMailer.seller_signup(Seller.first)
  end

  def seller_signup_notify_internal
    ApplicationMailer.seller_signup_notify_internal(Seller.first)
  end

  def new_place_notify_internal
    ApplicationMailer.new_place_notify_internal(Place.first)
  end

  def voucher_email
    ApplicationMailer.voucher_email(Voucher.first.id)
  end

  def seller_voucher_email
    ApplicationMailer.seller_voucher_email(Voucher.first.id)
  end

  def seller_place_published_notification
    ApplicationMailer.seller_place_published_notification(Place.first.id)
  end
end
