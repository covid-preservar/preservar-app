class AddPublishedAtToPlace < ActiveRecord::Migration[6.0]
  def change
    add_column :places, :published_at, :datetime
  end
end
