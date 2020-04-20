class AddTosAcceptanceToSellerUser < ActiveRecord::Migration[6.0]
  def change
    add_column :seller_users, :tos_accepted_at, :datetime
    add_column :seller_users, :privacy_policy_version_consented_to, :string
    add_column :seller_users, :terms_of_service_version_consented_to, :string
  end
end
