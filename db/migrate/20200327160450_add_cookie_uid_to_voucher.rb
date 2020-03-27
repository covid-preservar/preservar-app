class AddCookieUidToVoucher < ActiveRecord::Migration[6.0]
  def change
    add_column :vouchers, :cookie_uuid, :string
  end
end
