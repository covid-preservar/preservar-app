# frozen_string_literal: true
class VoucherPaymentCompleteJob
  include Sidekiq::Worker
  include Sidekiq::Throttled::Worker

  sidekiq_throttle({concurrency: { limit: 1 }})

  def perform(voucher_id)
    @voucher = Voucher.find(voucher_id)
    check_partner_limit

    InsurancePolicyService.new(@voucher).create_policy if @voucher.can_insure?

    ApplicationMailer.voucher_email(@voucher.id).deliver_later
    ApplicationMailer.seller_voucher_email(@voucher.id).deliver_later
  end

  private

  def check_partner_limit
    if @voucher.partner.present? &&
       @voucher.place.promo_limit_reached? &&
       !@voucher.place.partnership.limit_reached

      @voucher.place.partnership.update limit_reached: true
      ApplicationMailer.promo_limit_notify(@voucher.place.id).deliver_later
    end
  end
end