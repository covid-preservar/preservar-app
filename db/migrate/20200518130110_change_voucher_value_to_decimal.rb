class ChangeVoucherValueToDecimal < ActiveRecord::Migration[6.0]
  def change
    change_column :vouchers, :value, :decimal, precision: 5, scale: 2
    change_column :vouchers, :used_value, :decimal, precision: 5, scale: 2
  end
end
