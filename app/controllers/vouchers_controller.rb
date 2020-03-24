# frozen_string_literal: true
class VouchersController < ApplicationController

  def create
    @voucher = Voucher.new(voucher_params)
  end

  private

  def voucher_params
    params.require(:voucher).permit(:value, :custom_value, :seller_id)
  end
end
