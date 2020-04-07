class ReenableCompanyRegistrationCode < ActiveRecord::Migration[6.0]
  def change
    add_column :sellers, :company_registration_code, :string
  end
end
