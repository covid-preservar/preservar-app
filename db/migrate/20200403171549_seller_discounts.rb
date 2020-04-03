class SellerDiscounts < ActiveRecord::Migration[6.0]
  def change
    add_column :places, :has_discount, :boolean, default: false
  end
end
