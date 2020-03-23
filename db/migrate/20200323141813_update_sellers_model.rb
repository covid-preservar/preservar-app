class UpdateSellersModel < ActiveRecord::Migration[6.0]
  def change
    add_column :sellers, :slug, :string
    add_column :sellers, :address, :string
    add_column :sellers, :main_photo_data, :jsonb



    add_index :sellers, :slug, unique: true
    add_index :sellers, :city

  end
end
