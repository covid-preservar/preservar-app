class AddRemainderFlagToVoucher < ActiveRecord::Migration[6.0]
  def change
    add_column :vouchers, :is_remainder, :boolean, default: false
  end
end
