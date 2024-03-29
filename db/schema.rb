# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_08_06_012205) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id"
    t.index ["organization_id"], name: "index_product_types_on_organization_id"
  end

  create_table "shoes", force: :cascade do |t|
    t.string "color"
    t.date "date_received"
    t.date "date_due"
    t.string "owner"
    t.bigint "phone"
    t.string "type_of_payment"
    t.decimal "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "finished", default: false
    t.boolean "delivered", default: false
    t.string "product_type"
    t.string "brand"
    t.string "gender"
    t.text "task_description"
    t.boolean "paid_for", default: false
    t.string "location"
    t.bigint "organization_id"
    t.integer "id_within_organization", null: false
    t.datetime "delivered_date"
    t.date "updated_date_due"
    t.boolean "void", default: false
    t.boolean "update_date_due", default: false
    t.index ["organization_id"], name: "index_shoes_on_organization_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.bigint "organization_id"
    t.string "role"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "product_types", "organizations"
  add_foreign_key "shoes", "organizations"
  add_foreign_key "users", "organizations"
end
