class PaymentsController < ApplicationController

  def new
    voucher = Voucher.find(params[:voucher_id])

    redirect_to(voucher.seller, alert: 'Operação inválida') unless voucher.created?
    @payment = voucher.build_payment
  end
end
