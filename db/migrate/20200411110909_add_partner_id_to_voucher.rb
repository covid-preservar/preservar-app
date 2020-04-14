class AddPartnerIdToVoucher < ActiveRecord::Migration[6.0]
  def change
    add_reference :vouchers, :partner
  end
end
