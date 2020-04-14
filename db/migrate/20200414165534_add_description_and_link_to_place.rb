class AddDescriptionAndLinkToPlace < ActiveRecord::Migration[6.0]
  def change
    add_column :places, :description, :text
    add_column :places, :url, :string
  end
end
