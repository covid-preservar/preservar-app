class CustomPartnershipData < ActiveRecord::Migration[6.0]
  def change
    add_column :partnerships, :properties, :jsonb, default: {}, null: false
  end
end
