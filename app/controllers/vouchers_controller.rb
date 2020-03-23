class VouchersController < ApplicationController

  def create
    @voucher = Voucher.new(voucher_params)
    binding.pry
  end

  private

  def voucher_params
    params.require(:voucher).permit(:value, :custom_value, :seller_id)
  end
end