class UpdateSellersModel < ActiveRecord::Migration[6.0]
  def change
    add_column :sellers, :slug, :string
    add_column :sellers, :address, :string
    add_column :sellers, :main_photo_data, :jsonb
    add_column :sellers, :payment_api_key, :string
    add_column :sellers, :vat_id, :string
    add_column :sellers, :iban, :string
    add_column :sellers, :contact_name, :string
    add_column :sellers, :company_name, :string
    add_column :sellers, :company_registration_code, :string

    add_index :sellers, :slug, unique: true
    add_index :sellers, :city
  end
end
