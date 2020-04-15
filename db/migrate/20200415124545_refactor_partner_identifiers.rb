class RefactorPartnerIdentifiers < ActiveRecord::Migration[6.0]
  def change
    remove_column :partner_identifiers, :used
    remove_column :partner_identifiers, :place_id
    rename_column :partner_identifiers, :used_at, :last_used_at
    add_reference :partnerships, :partner_identifier, index: true
    add_column :partner_identifiers, :use_count, :integer, default: 0
  end
end
