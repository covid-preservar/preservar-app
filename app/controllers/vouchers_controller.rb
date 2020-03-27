# frozen_string_literal: true
class VouchersController < ApplicationController

  def create
    voucher = Voucher.new(voucher_params.merge(cookie_uuid: SecureRandom.uuid))
    if voucher.save
      cookies.encrypted[:uuid] = { value: voucher.cookie_uuid, expires: 1.hour }
      redirect_to new_voucher_payment_path(voucher)
    else
      redirect_to voucher.seller
    end
  end

  private

  def voucher_params
    params.require(:voucher).permit(:value, :custom_value, :seller_id)
  end
end
