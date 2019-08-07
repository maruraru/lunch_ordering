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

ActiveRecord::Schema.define(version: 2019_08_05_073401) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "menu_items", force: :cascade do |t|
    t.string "name", null: false
    t.string "category", null: false
    t.decimal "price", precision: 20, scale: 2, null: false
    t.string "photo"
    t.bigint "menu_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_menu_items_on_menu_id"
    t.index ["name"], name: "index_menu_items_on_name"
  end

  create_table "menus", force: :cascade do |t|
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_menus_on_date", unique: true
  end

  create_table "user_lunches", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "first_dish_id", null: false
    t.bigint "main_dish_id", null: false
    t.bigint "drink_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drink_id"], name: "index_user_lunches_on_drink_id"
    t.index ["first_dish_id"], name: "index_user_lunches_on_first_dish_id"
    t.index ["main_dish_id"], name: "index_user_lunches_on_main_dish_id"
    t.index ["user_id"], name: "index_user_lunches_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "is_admin", default: false
    t.string "user_name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
