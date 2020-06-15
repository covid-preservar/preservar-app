# frozen_string_literal: true
class VouchersController < ApplicationController

  def create
    redirect_to(root_url) and return unless Flipper.enabled?(:selling)

    @voucher = Voucher.new(voucher_params.merge(cookie_uuid: SecureRandom.uuid))

    if @voucher.place.active_partner.present?
      @voucher.partner = @voucher.place.active_partner
    end

    if @voucher.save
      @voucher.update_tracking(tracking_codes)
      cookies.encrypted[:uuid] = { value: @voucher.cookie_uuid, expires: 1.hour }
      redirect_to new_voucher_payment_path(@voucher), turbolinks: :advance
    else
      @place = @voucher.place
      render :new
    end
  end

  private

  def voucher_params
    params.require(:voucher).permit(:value, :custom_value, :place_id)
  end

  def tracking_codes
    codes = {}
    cookies.each do |key, value|
      codes[key] = cookies.signed[key] if key.starts_with?('utm_')
    end

    codes[:referrer] = cookies.signed[:referrer] if cookies.signed[:referrer].present?

    codes
  end
end
