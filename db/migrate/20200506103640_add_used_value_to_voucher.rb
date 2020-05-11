class AddUsedValueToVoucher < ActiveRecord::Migration[6.0]
  def change
    add_column :vouchers, :used_value, :integer, default: 0
  end
end
