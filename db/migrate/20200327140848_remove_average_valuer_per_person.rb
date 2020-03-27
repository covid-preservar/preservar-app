class RemoveAverageValuerPerPerson < ActiveRecord::Migration[6.0]
  def change
    remove_column :sellers, :average_value_per_person
  end
end
