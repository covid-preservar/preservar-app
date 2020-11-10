class CreateSigninTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :signin_tokens do |t|
      t.belongs_to :seller_user
      t.datetime :expires_at, null: false
      t.string :encrypted_uuid, null: false, index: true
      t.timestamps
    end
  end
end
