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

ActiveRecord::Schema.define(version: 20140220170931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "clinics", force: true do |t|
    t.string   "name"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "street_address_continued"
    t.text     "notes"
  end

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "phone"
    t.string   "email"
    t.text     "notes"
    t.integer  "clinic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "epi_breakdowns", force: true do |t|
    t.string   "name"
    t.integer  "clinic_id"
    t.float    "test_ct"
    t.float    "diag_ct"
    t.float    "test_gc"
    t.float    "diag_gc"
    t.float    "test_trich"
    t.float    "diag_trich"
    t.float    "test_hiv"
    t.float    "diag_hiv"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "population_breakdowns", force: true do |t|
    t.string   "name"
    t.float    "women"
    t.float    "msm"
    t.float    "under_26"
    t.float    "black"
    t.float    "hispanic"
    t.integer  "clinic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_offering_descriptions", force: true do |t|
    t.string   "name"
    t.integer  "clinic_id"
    t.boolean  "college_health"
    t.boolean  "community_health"
    t.boolean  "family_planning"
    t.boolean  "planned_parenthood"
    t.boolean  "private_practice"
    t.boolean  "std"
    t.boolean  "other"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
