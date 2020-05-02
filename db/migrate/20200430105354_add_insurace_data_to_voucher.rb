class AddInsuraceDataToVoucher < ActiveRecord::Migration[6.0]
  def change
    add_column :vouchers, :insurance_policy_number, :string
    add_column :vouchers, :insurance_temp_password, :string
  end
end
