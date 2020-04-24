class AddVatIdToPartnerIdentifier < ActiveRecord::Migration[6.0]
  def change
    add_column :partner_identifiers, :vat_id, :string
  end
end
