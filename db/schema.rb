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

ActiveRecord::Schema.define(version: 20150310092010) do

  create_table "alerts", force: :cascade do |t|
    t.integer  "child_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "report_id"
    t.datetime "acknowledged_on"
  end

  add_index "alerts", ["child_id"], name: "index_alerts_on_child_id"

  create_table "authentication_providers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "authentication_providers", ["name"], name: "index_name_on_authentication_providers"

  create_table "children", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "gender"
    t.date     "birthday"
    t.string   "slug"
  end

  add_index "children", ["slug"], name: "index_children_on_slug", unique: true

  create_table "toy_ownerships", force: :cascade do |t|
    t.integer  "toy_id"
    t.integer  "child_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "toy_ownerships", ["child_id"], name: "index_toy_ownerships_on_child_id"
  add_index "toy_ownerships", ["toy_id"], name: "index_toy_ownerships_on_toy_id"

  create_table "toy_reports", force: :cascade do |t|
    t.integer  "toy_id"
    t.string   "source"
    t.string   "recall_number"
    t.date     "recall_date"
    t.text     "hazard"
    t.text     "remedy"
    t.text     "description"
    t.text     "sold_at"
    t.string   "remedy_types"
    t.string   "importer"
    t.string   "manufactured_in"
    t.text     "consumer_contact"
    t.text     "incidents_reported"
    t.string   "units_sold"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "toy_reports", ["toy_id"], name: "index_toy_reports_on_toy_id"

  create_table "toys", force: :cascade do |t|
    t.string   "name"
    t.string   "added_via"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "status",             default: "pending"
    t.string   "maker"
    t.string   "image"
    t.string   "upc"
    t.string   "descriptions"
    t.integer  "minimum_age_months"
    t.integer  "maximum_age_months"
    t.string   "provider"
  end

  create_table "user_authentications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "authentication_provider_id"
    t.string   "uid"
    t.string   "token"
    t.datetime "token_expires_at"
    t.text     "params"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "user_authentications", ["authentication_provider_id"], name: "index_user_authentications_on_authentication_provider_id"
  add_index "user_authentications", ["user_id"], name: "index_user_authentications_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                   default: "",    null: false
    t.string   "encrypted_password",      default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "first_name"
    t.text     "last_name"
    t.text     "image"
    t.boolean  "subscribed_to_mailchimp", default: false
    t.boolean  "has_seen_alert_demo",     default: false
    t.string   "stripe_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
