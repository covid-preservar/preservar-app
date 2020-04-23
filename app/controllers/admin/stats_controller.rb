module Admin
  class StatsController < Admin::BaseController

    def index
      voucher_counts = Voucher.paid.group_by_day(:payment_completed_at).count
      voucher_values = Voucher.paid.group_by_day(:payment_completed_at).sum(:value)
      @voucher_stats = voucher_counts.merge(voucher_values){|_, count, val| [count, val]}

      seller_count =  Seller.group_by_day(:created_at).count
      seller_published =  Seller.where(id: Place.published.select(:seller_id)).distinct.group_by_day(:created_at).count
      dates = (seller_count.keys + seller_published.keys).uniq

      @seller_stats = dates.each.with_object({}) do |date, stats|
        stats[date] = [seller_count[date] || 0, seller_published[date] || 0]
      end

    end

  end
end