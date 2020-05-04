# frozen_string_literal: true
class Seller::VouchersController < Seller::BaseController

  def index
    base_scope = current_seller_user.seller.vouchers.seller_visible
    @q = base_scope.ransack(params[:q])
    @vouchers = params[:q].present? ? @q.result.order(:state) : base_scope.all.order(:state)
  end

  def update
    voucher = Voucher.find(params[:id])
    @form = VoucherRedeemForm.new(redeem_params.merge(voucher: voucher))

    if @form.save
      redirect_to seller_vouchers_path, notice: 'Voucher marcado como usado'
    else
      render :redeem
    end
  end

  def redeem
    voucher = Voucher.find(params[:id])

    @form = VoucherRedeemForm.new(voucher: voucher)
  end

  private

  def redeem_params
    params.require(:voucher_redeem_form).permit(:used_value)
  end
end
