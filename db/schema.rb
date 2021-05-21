# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_21_064826) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bands", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.text "style"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_bands_on_user_id"
  end

  create_table "gigs", force: :cascade do |t|
    t.string "title"
    t.string "location"
    t.string "start_time"
    t.string "end_time"
    t.decimal "ask_price"
    t.boolean "active"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "date"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_gigs_on_user_id"
  end

  create_table "negotiations", force: :cascade do |t|
    t.decimal "ask_price"
    t.decimal "offer_price"
    t.boolean "accepted"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "accepted_price"
    t.bigint "band_id", null: false
    t.bigint "gig_id", null: false
    t.index ["band_id"], name: "index_negotiations_on_band_id"
    t.index ["gig_id"], name: "index_negotiations_on_gig_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email", default: "", null: false
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bands", "users"
  add_foreign_key "gigs", "users"
  add_foreign_key "negotiations", "bands"
  add_foreign_key "negotiations", "gigs"
end
