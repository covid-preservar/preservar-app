task :reactivate_sb_partners => :environment do
  p = Partner.find(2)
  p.voucher_limit = 30
  p.save!

  Partnership.where(limit_reached: true, partner_id: 2).each do |ps|
    if ps.place.vouchers.total_paid < 30
      ps.update! limit_reached: false
    end
  end
end