class CreateSeller < ActiveRecord::Migration[6.0]
  def change
    create_table :sellers do |t|
      t.string :name
      t.references :category
      t.integer :average_value_per_person
      t.timestamps
    end
  end
end
