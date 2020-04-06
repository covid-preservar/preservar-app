class AddIbanToSeller < ActiveRecord::Migration[6.0]
  def change
    add_column :sellers, :iban, :string
  end
end
