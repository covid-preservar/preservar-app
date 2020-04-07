class CleanDeadVouchers < ApplicationJob

  def perform
    # Vouchers in a "created" state for more than 1 day are dead
    Voucher.created.where('updated_at < ?', 1.day.ago).delete_all

    # Vouchers in a "pending_payment" state for more than 2 days are dead
    Voucher.pending_payment.where('updated_at < ?', 2.days.ago).delete_all
  end
end