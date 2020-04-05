class AddVatIdToVoucher < ActiveRecord::Migration[6.0]
  def change
    add_column :vouchers, :vat_id, :string
  end
end
