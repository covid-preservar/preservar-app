class CreatePartner < ActiveRecord::Migration[6.0]
  def change
    create_table :partners do |t|
      t.string :type
      t.string :name
      t.jsonb :large_logo_data
      t.jsonb :small_logo_data
      t.string :place_page_copy
      t.string :voucher_copy
      t.jsonb :partner_properties, default: {}, null: false

      t.timestamps
    end

    create_table :partnerships do |t|
      t.references :partner, index: true
      t.references :place, index: true
      t.boolean :approved, default: false, null: false
      t.timestamps
    end
  end
end
