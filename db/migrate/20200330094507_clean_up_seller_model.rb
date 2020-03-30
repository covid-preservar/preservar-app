class CleanUpSellerModel < ActiveRecord::Migration[6.0]
  def change
    remove_column :sellers, :iban
    remove_column :sellers, :company_registration_code
  end
end
