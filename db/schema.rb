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

ActiveRecord::Schema.define(version: 20150301123523) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "access_token"
    t.string   "access_secret"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", unique: true, using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "galleries", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "cover"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "product_id"
    t.string   "name"
    t.string   "email"
    t.string   "street"
    t.string   "zip"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "tracking_code"
    t.text     "html_string"
    t.boolean  "andrews_notified",              default: false
    t.boolean  "fulfilled",                     default: false
    t.boolean  "customer_notified_of_shipment", default: false
    t.boolean  "cancelled",                     default: false
    t.boolean  "refunded",                      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pictures", force: true do |t|
    t.string   "description"
    t.string   "image"
    t.integer  "gallery_id"
    t.string   "gallery_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "settings"
  end

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "slug"
    t.text     "content"
    t.boolean  "published",         default: false
    t.string   "permalink_path"
    t.datetime "published_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "protect_slug",      default: false
    t.text     "meta_description"
    t.string   "image_url_string"
    t.boolean  "url_contains_date", default: false
    t.boolean  "featured",          default: false
    t.boolean  "guest",             default: false
    t.boolean  "simple_layout",     default: false
  end

  add_index "posts", ["slug"], name: "index_posts_on_slug", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "products", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "price_in_cents"
    t.string   "image_url_string"
    t.boolean  "featured",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "features"
  end

  create_table "tweets", force: true do |t|
    t.integer  "authentication_id"
    t.string   "body"
    t.boolean  "sent",              default: false
    t.datetime "send_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tweets", ["authentication_id"], name: "index_tweets_on_authentication_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "role"
    t.string   "slug"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.string   "encrypted_password",     limit: 128, default: "", null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "access_token"
    t.string   "access_secret"
    t.string   "avatar"
    t.string   "twitter_handle"
    t.text     "bio"
    t.string   "catchphrase"
    t.string   "google_plus"
    t.string   "website"
  end

  add_index "users", ["slug"], name: "index_users_on_slug", using: :btree

end
