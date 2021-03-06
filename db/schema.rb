# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151108051032) do

  create_table "comments", force: :cascade do |t|
    t.text     "message",       limit: 65535
    t.integer  "restaurant_id", limit: 4
    t.integer  "customer_id",   limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "rating",        limit: 4
  end

  add_index "comments", ["customer_id"], name: "index_comments_on_customer_id", using: :btree
  add_index "comments", ["restaurant_id"], name: "index_comments_on_restaurant_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "address",    limit: 65535
    t.string   "zip",        limit: 255
    t.string   "phone",      limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.float    "latitude",   limit: 24
    t.float    "longitude",  limit: 24
  end

  add_index "customers", ["user_id"], name: "index_customers_on_user_id", using: :btree

  create_table "foods", force: :cascade do |t|
    t.string   "name",          limit: 255,                                       null: false
    t.decimal  "price",                       precision: 5, scale: 2
    t.integer  "num_left",      limit: 4,                             default: 0
    t.integer  "num_sold",      limit: 4,                             default: 0
    t.text     "description",   limit: 65535
    t.string   "image",         limit: 255
    t.integer  "restaurant_id", limit: 4
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
  end

  add_index "foods", ["restaurant_id"], name: "index_foods_on_restaurant_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.decimal  "price",                       precision: 5, scale: 2
    t.boolean  "paid"
    t.boolean  "ready"
    t.boolean  "assigned"
    t.boolean  "arrived"
    t.text     "address",       limit: 65535
    t.string   "zip",           limit: 255
    t.string   "phone",         limit: 255
    t.datetime "shipped_at"
    t.datetime "arrived_at"
    t.datetime "confirmed_at"
    t.integer  "restaurant_id", limit: 4
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.integer  "user_id",       limit: 4
    t.text     "food_json",     limit: 65535
    t.integer  "shipper_id",    limit: 4
  end

  add_index "orders", ["restaurant_id"], name: "index_orders_on_restaurant_id", using: :btree
  add_index "orders", ["shipper_id"], name: "index_orders_on_shipper_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "restaurants", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "address",    limit: 65535
    t.string   "zip",        limit: 255
    t.string   "phone",      limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.float    "latitude",   limit: 24
    t.float    "longitude",  limit: 24
  end

  add_index "restaurants", ["user_id"], name: "index_restaurants_on_user_id", using: :btree

  create_table "shippers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "address",    limit: 65535
    t.string   "zip",        limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "phone",      limit: 255
  end

  add_index "shippers", ["user_id"], name: "index_shippers_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "role",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "comments", "customers"
  add_foreign_key "comments", "restaurants"
  add_foreign_key "customers", "users"
  add_foreign_key "foods", "restaurants"
  add_foreign_key "orders", "restaurants"
  add_foreign_key "orders", "shippers"
  add_foreign_key "orders", "users"
  add_foreign_key "restaurants", "users"
  add_foreign_key "shippers", "users"
end
