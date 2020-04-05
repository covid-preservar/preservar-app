class AddValidUntilToVoucher < ActiveRecord::Migration[6.0]
  def change
    add_column :vouchers, :valid_until, :date
  end
end
