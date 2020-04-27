class AddTimestampsToVoucher < ActiveRecord::Migration[6.0]
  def change
    add_column :vouchers, :redeemed_at, :datetime
    add_column :vouchers, :refunded_at, :datetime
  end
end
