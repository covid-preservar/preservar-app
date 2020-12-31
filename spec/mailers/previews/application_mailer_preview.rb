# frozen_string_literal: true
class ApplicationMailerPreview < ActionMailer::Preview

  def seller_signup
    ApplicationMailer.seller_signup(Seller.first)
  end

  def new_place_notify_internal
    ApplicationMailer.new_place_notify_internal(Place.first)
  end

  def voucher_email
    ApplicationMailer.voucher_email(Voucher.paid.last.id)
  end

  def seller_voucher_email
    ApplicationMailer.seller_voucher_email(Voucher.last.id)
  end

  def seller_place_published_notification
    ApplicationMailer.seller_place_published_notification(Place.first.id)
  end

  def csv_import_notification
    ApplicationMailer.csv_import_notification(CSVImport.last.id)
  end

  def promo_limit_notify
    ApplicationMailer.promo_limit_notify(AddOnPartner.last.vouchers.last.place_id)
  end

  def remainder_voucher_email
    ApplicationMailer.remainder_voucher_email(new_voucher_id: Voucher.paid.last.id, original_voucher_id: Voucher.paid.first.id)
  end

  def seller_promo_limit_notify
    ApplicationMailer.seller_promo_limit_notify(Place.last.id)
  end

  ### TEMP

  def voucher_gained_bonus
    ApplicationMailer.voucher_gained_bonus(AddOnPartner.first.vouchers.paid.last.id)
  end
end
