class AddCityToSeller < ActiveRecord::Migration[6.0]
  def change
    add_column :sellers, :city, :string, null: false
  end
end
