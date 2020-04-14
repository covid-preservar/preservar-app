class AddMissingFks < ActiveRecord::Migration[6.0]
  def change

    add_foreign_key :vouchers, :places
    add_foreign_key :partnerships, :places
    add_foreign_key :partnerships, :partners
    add_foreign_key :places, :categories
    add_foreign_key :places, :sellers
    add_foreign_key :sellers, :seller_users

  end
end
