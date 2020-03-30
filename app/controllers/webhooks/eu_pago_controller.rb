# frozen_string_literal: true
class Webhooks::EuPagoController < ActionController::Base

  # PARAMS
  # valor=93.32
  # canal=nome_cana_eupago
  # referencia=XXXXXXXXX
  # transacao=XXXXXXXXX
  # identificador=o_idetifcador
  # mp=MW:PT
  # chave_api=mmmm-jjjj-2364-3631-1b7b
  # data=2020-03-24:19:08:36
  # entidade=00000
  # comissao=0.89
  # local=Porto

  def webhook
    voucher = Voucher.find_by(payment_identifier: params[:identificador])

    unless voucher.present?
      Rollbar.warning('Payment Webhook: Not found', params: params)
      render(status: :unprocessable_entity, plain: 'No payment found for that identifier') and return
    end

    value = params[:valor].to_f.round

    if voucher.seller.payment_api_key != params[:chave_api]
      Rollbar.warning('Payment Webhook: API Key mismatch', params: params, expected: voucher.seller.payment_api_key)
      render(status: :unprocessable_entity, plain: 'API Key mismatch') and return
    end

    if voucher.value != value
      Rollbar.warning('Payment Webhook: Value mismatch', params: params, expected: voucher.value)
      render(status: :unprocessable_entity, plain: 'Payment value mismatch') and return
    end

    if voucher.pending_payment?
      voucher.payment_success!
      ApplicationMailer.voucher_email(voucher).deliver_later
      # ApplicationMailer.seller_voucher_email(voucher).deliver_later
    end

    head :ok
  end

  private

  def payment_params
    params.slice(:valor, :referencia, :transacao,
                 :identificador, :chave_api, :data,
                 :entidade).permit!
  end
end