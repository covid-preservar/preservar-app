module Admin
  class StatsController < Admin::ApplicationController

    def index
      voucher_counts = Voucher.paid.group_by_day(:payment_completed_at).count
      voucher_values = Voucher.paid.group_by_day(:payment_completed_at).sum(:value)
      @voucher_stats = voucher_counts.merge(voucher_values){|_, count, val| [count, val]}.reverse_each
    end

  end
end