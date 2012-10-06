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

ActiveRecord::Schema.define(:version => 20121006041021) do

  create_table "after_photos", :force => true do |t|
    t.integer  "workorder_id"
    t.string   "photo"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "assetnotes", :force => true do |t|
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "asset_id"
  end

  create_table "assets", :force => true do |t|
    t.string   "name"
    t.string   "serial"
    t.integer  "workorder_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "status"
    t.boolean  "ready"
    t.string   "water_plumbing"
    t.string   "drain_plumbing"
    t.string   "electrical_option"
  end

  create_table "before_photos", :force => true do |t|
    t.integer  "workorder_id"
    t.string   "photo"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "bugs", :force => true do |t|
    t.string   "name"
    t.boolean  "fixed"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.text     "request_type"
    t.boolean  "complete"
  end

  create_table "chemicals", :force => true do |t|
    t.string   "name"
    t.integer  "quantity"
    t.integer  "asset_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "fulfillments", :force => true do |t|
    t.integer  "machine_id"
    t.integer  "workorder_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "machines", :force => true do |t|
    t.string   "model_number"
    t.string   "serial_number"
    t.integer  "option_id"
    t.string   "misc_notes"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "options", :force => true do |t|
    t.string   "name"
    t.integer  "asset_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "parts", :force => true do |t|
    t.string   "name"
    t.integer  "qty"
    t.text     "comment"
    t.integer  "user_id"
    t.integer  "branch"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "updates", :force => true do |t|
    t.string   "feed_item"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "admin"
    t.string   "role"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.integer  "current_branch"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "workorders", :force => true do |t|
    t.string   "customer"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.datetime "wo_date"
    t.time     "wo_start"
    t.integer  "wo_duration"
    t.string   "contact"
    t.integer  "phonenumber"
    t.string   "misc_notes"
    t.integer  "branch"
    t.boolean  "completed"
    t.string   "wo_type"
  end

end
