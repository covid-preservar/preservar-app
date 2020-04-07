class AddPaymentAtToVouchers < ActiveRecord::Migration[6.0]
  def change
    add_column :vouchers, :payment_completed_at, :datetime

    reversible do |dir|
      dir.up do
        Voucher.paid.each do |v|
          v.update_column :payment_completed_at, v.updated_at
        end
      end
    end
  end
end
