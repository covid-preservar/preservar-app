class CreatePartnerIdentifiers < ActiveRecord::Migration[6.0]
  def change
    create_table :partner_identifiers do |t|
      t.belongs_to :partner, null: false, index: true, foreign_key: true
      t.belongs_to :place, index: true
      t.string :identifier
      t.boolean :used, default: false, null: false
      t.timestamp :used_at
    end
  end
end
