class AddRoleToAdmin < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :role, :integer, default:0
  end
end
