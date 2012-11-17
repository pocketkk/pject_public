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

ActiveRecord::Schema.define(:version => 20121117153051) do

  create_table "after_photos", :force => true do |t|
    t.integer  "workorder_id"
    t.string   "photo"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "asset_photos", :force => true do |t|
    t.integer  "asset_id"
    t.string   "photo"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "commentable_id"
    t.integer  "user_id"
    t.string   "commentable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "documents", :force => true do |t|
    t.string   "pdfdoc"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "emails", :force => true do |t|
    t.string   "address"
    t.integer  "document_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "message"
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
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "part_number"
    t.string   "po_number"
    t.boolean  "ordered"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
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
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.integer  "current_branch"
    t.string   "phone_number"
    t.boolean  "texts",           :default => false
    t.text     "signature"
    t.boolean  "receive_mails",   :default => true
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "videos", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "yt_video_id"
    t.boolean  "is_complete", :default => false
    t.integer  "user_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

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
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.integer  "assigned_to"
  end

end
