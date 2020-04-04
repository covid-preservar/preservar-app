class SchemaFixes < ActiveRecord::Migration[6.0]
  def change
    change_column :places, :published, :boolean, default: false

    add_index :places, :published
    add_index :places, :category_id

    remove_column :seller_users, :old_seller_id
  end
end
