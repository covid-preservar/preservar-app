class AddBonusFieldsToVoucher < ActiveRecord::Migration[6.0]
  def change
    add_column :vouchers, :mbway_bonus, :integer, default: 0
    add_column :vouchers, :add_on_bonus, :integer, default: 0

    reversible do |dir|
      dir.up do
        Voucher.where(partner_id: [2, 3]).update_all add_on_bonus: 5
      end
    end
  end
end
