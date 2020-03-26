# frozen_string_literal: true
class VouchersController < ApplicationController

  def create
    voucher = Voucher.new(voucher_params)
    if voucher.save
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
