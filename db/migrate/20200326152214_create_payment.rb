class CreatePayment < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.references :voucher
      t.string :identifier
      t.integer :amount
      t.string :method
      t.timestamps
    end
  end
end
