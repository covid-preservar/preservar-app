class AddIndexToSellerName < ActiveRecord::Migration[6.0]
  def change
    add_index :sellers, :name
  end
end
