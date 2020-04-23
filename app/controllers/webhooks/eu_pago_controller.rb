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
    notification = PaymentNotification.create(data: params)

    voucher = Voucher.find_by(payment_identifier: params[:identificador])

    unless voucher.present?
      notification.update status: 'id_not_found'
      Rollbar.warning('Payment Webhook: Not found', params: params)
      render(status: :unprocessable_entity, plain: 'No payment found for that identifier') and return
    end

    value = params[:valor].to_f.round

    if voucher.place.seller.payment_api_key != params[:chave_api]
      notification.update status: 'bad_api_key'
      Rollbar.warning('Payment Webhook: API Key mismatch',
                      params: params,
                      expected: voucher.place.seller.payment_api_key)
      render(status: :unprocessable_entity, plain: 'API Key mismatch') and return
    end

    if voucher.value != value
      notification.update status: 'bad_value'
      Rollbar.warning('Payment Webhook: Value mismatch', params: params, expected: voucher.value)
      render(status: :unprocessable_entity, plain: 'Payment value mismatch') and return
    end

    if voucher.pending_payment?
      notification.update status: 'ok'
      voucher.payment_success!
      ApplicationMailer.voucher_email(voucher.id).deliver_later
      ApplicationMailer.seller_voucher_email(voucher.id).deliver_later

      if voucher.partner.present? &&
         voucher.place.promo_limit_reached? &&
         voucher.place.vouchers.paid.count >= voucher.partner.voucher_limit &&
         !voucher.place.partnership.limit_reached

        voucher.place.partnership.update limit_reached: true
        ApplicationMailer.promo_limit_notify(voucher.place.id).deliver_later
      end
    else
      notification.update status: "voucher_state_was_#{voucher.state}"
      render(status: :unprocessable_entity, plain: 'Voucher state does not allow this operation') and return
    end

    head :ok
  end
end