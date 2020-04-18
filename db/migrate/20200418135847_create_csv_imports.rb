class CreateCSVImports < ActiveRecord::Migration[6.0]
  def change
    create_table :csv_imports do |t|
      t.references :admin_user
      t.jsonb :file_data
      t.jsonb :processing_errors, default: {}
      t.integer :state, default: 0
    end
  end
end
