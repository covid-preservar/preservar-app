class FixCSVImportModel < ActiveRecord::Migration[6.0]
  def change
    add_column :csv_imports, :published_place_ids, :integer, array: true, default: []
  end
end
