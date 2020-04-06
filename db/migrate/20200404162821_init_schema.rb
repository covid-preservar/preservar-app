class InitSchema < ActiveRecord::Migration[6.0]
  def up
    # These are extensions that must be enabled in order to support this database
    enable_extension "plpgsql"
    create_table "admin_users" do |t|
      t.string "email", default: "", null: false
      t.string "encrypted_password", default: "", null: false
      t.string "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer "sign_in_count", default: 0, null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.inet "current_sign_in_ip"
      t.inet "last_sign_in_ip"
      t.string "confirmation_token"
      t.datetime "confirmed_at"
      t.datetime "confirmation_sent_at"
      t.string "unconfirmed_email"
      t.integer "failed_attempts", default: 0, null: false
      t.string "unlock_token"
      t.datetime "locked_at"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["confirmation_token"], name: "index_admin_users_on_confirmation_token", unique: true
      t.index ["email"], name: "index_admin_users_on_email", unique: true
      t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
      t.index ["unlock_token"], name: "index_admin_users_on_unlock_token", unique: true
    end
    create_table "categories" do |t|
      t.string "name"
      t.string "name_plural"
    end
    create_table "locations" do |t|
      t.string "district"
      t.string "area"
      t.string "aliases", default: [], array: true
    end
    create_table "payment_notifications" do |t|
      t.jsonb "data"
      t.string "status"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
    end
    create_table "places" do |t|
      t.string "name"
      t.bigint "category_id"
      t.datetime "created_at", precision: 6
      t.datetime "updated_at", precision: 6
      t.string "area", null: false
      t.string "slug"
      t.string "address"
      t.jsonb "main_photo_data"
      t.boolean "published", default: false
      t.bigint "seller_id"
      t.boolean "has_discount", default: false
      t.datetime "published_at"
      t.index ["category_id"], name: "index_places_on_category_id"
      t.index ["published"], name: "index_places_on_published"
      t.index ["seller_id"], name: "index_places_on_seller_id"
      t.index ["slug"], name: "index_places_on_slug", unique: true
    end
    create_table "seller_users" do |t|
      t.string "email", default: "", null: false
      t.string "encrypted_password", default: "", null: false
      t.string "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["email"], name: "index_seller_users_on_email", unique: true
      t.index ["reset_password_token"], name: "index_seller_users_on_reset_password_token", unique: true
    end
    create_table "sellers" do |t|
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.string "payment_api_key"
      t.string "vat_id"
      t.string "contact_name"
      t.string "company_name"
      t.bigint "seller_user_id"
      t.index ["seller_user_id"], name: "index_sellers_on_seller_user_id"
    end
    create_table "vouchers" do |t|
      t.string "code"
      t.integer "value"
      t.bigint "place_id"
      t.string "state"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.string "email"
      t.string "payment_identifier"
      t.string "payment_method"
      t.string "payment_phone"
      t.string "cookie_uuid"
      t.integer "discount_percent", default: 0
      t.index ["payment_identifier"], name: "index_vouchers_on_payment_identifier"
      t.index ["place_id"], name: "index_vouchers_on_place_id"
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "The initial migration is not revertable"
  end
end
