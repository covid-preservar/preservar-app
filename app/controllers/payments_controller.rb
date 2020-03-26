# frozen_string_literal: true
class PaymentsController < ApplicationController

  def new
    @voucher = Voucher.find(params[:voucher_id])

    redirect_to(@voucher.seller, alert: 'Operação inválida') unless @voucher.created?
  end

  def create
    @voucher = Voucher.find(params[:voucher_id])

    @voucher.assign_attributes(payment_params)
    if @voucher.start_payment!
      # Open modal here
    else
      render :new
    end
  end

  private

  def payment_params
    params.require(:voucher).permit(:email, :payment_method, :payment_phone)
  end
end
