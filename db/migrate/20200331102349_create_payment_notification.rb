class CreatePaymentNotification < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_notifications do |t|
      t.jsonb :data
      t.string :status
      t.timestamps
    end
  end
end
