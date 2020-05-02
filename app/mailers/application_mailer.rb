# frozen_string_literal: true
class ApplicationMailer < ActionMailer::Base
  default from: 'Preserve <info@preserve.pt>'
  layout 'mailer'

  def seller_signup(seller)
    @seller = seller
    mail to: @seller.seller_user.email, subject:'Confirmação de registo no Preserve'
  end

  def new_place_notify_internal(place)
    @place = place
    mail to:'eupago@preserve.pt', subject:'Comerciante criou novo local'
  end

  def voucher_email(voucher_id)
    @voucher = Voucher.find(voucher_id)
    mail to:@voucher.email, subject: 'Parabéns pelo apoio! Aqui está o seu vale.'
  end

  def seller_voucher_email(voucher_id)
    @voucher = Voucher.find(voucher_id)
    mail to: @voucher.place.seller.seller_user.email, subject: "Preserve - Vendeu um vale!"
  end

  def seller_place_published_notification(place_id)
    @place = Place.find(place_id)
    mail to: @place.seller.seller_user.email, subject: "Preserve - Publicámos o seu local!"
  end

  def csv_import_notification(import_id)
    @import = CSVImport.find(import_id)
    mail to: @import.admin_user.email, subject: "[Preserve] CSV Import done"
  end

  def promo_limit_notify(place_id)
    @place = Place.find(place_id)
    mail to: AdminUser.all.map(&:email), subject: "[Preserve] Bonused voucher limit reached"
  end

  #### TEMP
  def followup_insurance_email(voucher_id)
    @voucher = Voucher.find voucher_id
    mail to:@voucher.email, subject: 'Dados de conta Keep Warranty'
  end
end
