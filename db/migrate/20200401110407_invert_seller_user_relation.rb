class InvertSellerUserRelation < ActiveRecord::Migration[6.0]
  def change
    add_reference :sellers, :seller_user

    reversible do |dir|
      dir.up do
        Seller.all.each do |s|
          s.update_column :seller_user_id, SellerUser.find_by(seller_id: s.id).id
        end
      end
    end

    change_column :seller_users, :seller_id, :bigint, null: true
    rename_column :seller_users, :seller_id, :old_seller_id
  end
end
