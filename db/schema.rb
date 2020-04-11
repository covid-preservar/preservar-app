# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_11_110909) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
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

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "name_plural"
  end

  create_table "flipper_features", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["key"], name: "index_flipper_features_on_key", unique: true
  end

  create_table "flipper_gates", force: :cascade do |t|
    t.string "feature_key", null: false
    t.string "key", null: false
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["feature_key", "key", "value"], name: "index_flipper_gates_on_feature_key_and_key_and_value", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "district"
    t.string "area"
    t.string "aliases", default: [], array: true
  end

  create_table "partners", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.string "slug"
    t.jsonb "large_logo_data"
    t.jsonb "small_logo_data"
    t.string "place_page_copy"
    t.string "voucher_copy"
    t.jsonb "partner_properties", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "partnerships", force: :cascade do |t|
    t.bigint "partner_id"
    t.bigint "place_id"
    t.boolean "approved", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["partner_id"], name: "index_partnerships_on_partner_id"
    t.index ["place_id"], name: "index_partnerships_on_place_id"
  end

  create_table "payment_notifications", force: :cascade do |t|
    t.jsonb "data"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "places", force: :cascade do |t|
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

  create_table "seller_users", force: :cascade do |t|
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

  create_table "sellers", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "payment_api_key"
    t.string "vat_id"
    t.string "contact_name"
    t.string "company_name"
    t.bigint "seller_user_id"
    t.string "iban"
    t.string "company_registration_code"
    t.index ["seller_user_id"], name: "index_sellers_on_seller_user_id"
  end

  create_table "vouchers", force: :cascade do |t|
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
    t.string "vat_id"
    t.date "valid_until"
    t.datetime "payment_completed_at"
    t.bigint "partner_id"
    t.index ["partner_id"], name: "index_vouchers_on_partner_id"
    t.index ["payment_identifier"], name: "index_vouchers_on_payment_identifier"
    t.index ["place_id"], name: "index_vouchers_on_place_id"
  end

end
