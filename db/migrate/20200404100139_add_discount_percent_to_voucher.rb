class AddDiscountPercentToVoucher < ActiveRecord::Migration[6.0]
  def change
    add_column :vouchers, :discount_percent, :integer, default: 0
  end
end
