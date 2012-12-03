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

ActiveRecord::Schema.define(:version => 20121203013131) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.datetime "date"
    t.string   "location"
    t.string   "link"
    t.string   "author"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "gmaps"
    t.string   "picture"
    t.boolean  "contains_hatespeech"
  end

  create_table "articles_locations", :id => false, :force => true do |t|
    t.integer "location_id"
    t.integer "article_id"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "date"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "country"
    t.string   "province"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "gmaps"
  end

  create_table "events_locations", :id => false, :force => true do |t|
    t.integer "location_id"
    t.integer "event_id"
  end

  create_table "hate_speeches", :force => true do |t|
    t.string   "speaker"
    t.text     "body"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hate_speeches", ["article_id"], :name => "index_hate_speeches_on_article_id"

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
    t.boolean  "gmap"
  end

  create_table "sources", :force => true do |t|
    t.string   "name"
    t.string   "home_page"
    t.string   "url"
    t.integer  "quality_rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_scraped"
    t.string   "feed_type",      :default => "RSS"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name",             :default => "",    :null => false
    t.string   "last_name",              :default => "",    :null => false
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
