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

ActiveRecord::Schema[7.0].define(version: 2022_11_30_210220) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "passwords", force: :cascade do |t|
    t.string "password_digest", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_token_sent_at"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["reset_password_token"], name: "index_passwords_on_reset_password_token", unique: true
    t.index ["user_id"], name: "index_passwords_on_user_id"
  end

  create_table "refresh_tokens", force: :cascade do |t|
    t.string "token", null: false
    t.datetime "expires_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_refresh_tokens_on_user_id"
  end

  create_table "user_secrets", force: :cascade do |t|
    t.string "secret", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_user_secrets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "role", default: 0
    t.string "country", default: ""
    t.boolean "confirmed", default: false
    t.string "confirmation_token"
    t.datetime "confirmation_token_sent_at"
    t.datetime "deleted_at"
    t.boolean "recovered", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  end

  add_foreign_key "passwords", "users"
  add_foreign_key "refresh_tokens", "users"
  add_foreign_key "user_secrets", "users"
end
