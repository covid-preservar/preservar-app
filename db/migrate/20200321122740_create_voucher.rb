class CreateVoucher < ActiveRecord::Migration[6.0]
  def change
    create_table :vouchers do |t|
      t.string :code
      t.integer :value
      t.references :seller
      t.string :state
      t.timestamps
    end
  end
end
