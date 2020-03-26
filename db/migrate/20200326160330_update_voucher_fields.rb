class UpdateVoucherFields < ActiveRecord::Migration[6.0]
  def change
    add_column :vouchers, :email, :string
    add_column :vouchers, :payment_identifier, :string
    add_column :vouchers, :payment_method, :string
    add_column :vouchers, :payment_phone, :string
  end
end
