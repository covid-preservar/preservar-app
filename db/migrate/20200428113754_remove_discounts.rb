class RemoveDiscounts < ActiveRecord::Migration[6.0]
  def change
    remove_column :places, :has_discount
    remove_column :vouchers, :discount_percent
  end
end
