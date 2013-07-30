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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130730214520) do

  create_table "categories", :force => true do |t|
    t.integer  "restaurant_id"
    t.string   "name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "choices", :force => true do |t|
    t.integer  "order_id"
    t.integer  "item_id"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "cost"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "restaurant_id"
    t.integer  "category_id"
  end

  create_table "items_orders", :force => true do |t|
    t.integer "item_id"
    t.integer "order_id"
    t.integer "quantity"
    t.string  "description"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "claimer_id"
    t.string   "phone_number"
    t.string   "house_dorm"
    t.string   "room"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.time     "expiration"
    t.boolean  "paid"
    t.integer  "restaurant_id"
    t.text     "description"
    t.integer  "cost"
    t.integer  "tip"
    t.integer  "total"
    t.string   "payment_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.text     "item_ids"
  end

  add_index "orders", ["user_id", "claimer_id"], :name => "index_orders_on_user_id_and_claimer_id"

  create_table "restaurants", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "approved"
    t.string   "address"
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "house_dorm"
    t.string   "room"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.integer  "order_stars"
    t.integer  "orders"
    t.integer  "delivery_stars"
    t.integer  "deliveries"
    t.integer  "clearance"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
