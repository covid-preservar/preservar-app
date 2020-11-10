class AddActiveFlagToPartners < ActiveRecord::Migration[6.0]
  def change
    add_column :partners, :published, :boolean, default: :false
  end
end
