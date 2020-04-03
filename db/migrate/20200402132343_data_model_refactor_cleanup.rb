class DataModelRefactorCleanup < ActiveRecord::Migration[6.0]
  def change
    remove_index :sellers, :area
    remove_index :sellers, :category_id

    remove_column :sellers, :name
    remove_column :sellers, :category_id
    remove_column :sellers, :area
    remove_column :sellers, :slug
    remove_column :sellers, :address
    remove_column :sellers, :published
    remove_column :sellers, :main_photo_data

    drop_table :friendly_id_slugs
  end
end
