task :reactivate_sb_partners => :environment do
  p = Partner.find(2)
  p.voucher_limit = 30
  p.save!

  Partnership.where(limit_reached: true, partner_id: 2).each do |ps|
    if ps.place.vouchers.total_paid.with_bonus.count < 30
      last_payment = ps.place.vouchers.total_paid.with_bonus.maximum(:payment_completed_at)
      bonused_count = ps.place.vouchers.total_paid.with_bonus.count

      ps.place
        .vouchers
        .total_paid
        .where(add_on_bonus: 0)
        .where('payment_completed_at >= ?', last_payment)
        .order(payment_completed_at: :asc)
        .limit(30 - bonused_count).each do |v|
        v.update! add_on_bonus: 5, partner_id: 2
        ApplicationMailer.voucher_gained_bonus(v.id).deliver_later
      end
    end

    if ps.place.vouchers.total_paid.with_bonus.count < 30
      ps.update! limit_reached: false
    end
  end
end