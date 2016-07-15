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

ActiveRecord::Schema.define(version: 20160714164852) do

  create_table "bugs", force: :cascade do |t|
    t.string   "application_token", limit: 255
    t.integer  "number",            limit: 4
    t.integer  "status",            limit: 4
    t.integer  "priority",          limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.text     "comment",           limit: 65535
  end

  add_index "bugs", ["application_token", "number"], name: "index_bugs_on_application_token_and_number", unique: true, using: :btree
  add_index "bugs", ["application_token"], name: "index_bugs_on_application_token", using: :btree
  add_index "bugs", ["number"], name: "index_bugs_on_number", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "device",     limit: 255
    t.string   "os",         limit: 255
    t.integer  "memory",     limit: 4
    t.integer  "storage",    limit: 4
    t.integer  "bug_id",     limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "states", ["bug_id"], name: "index_states_on_bug_id", using: :btree

  add_foreign_key "states", "bugs"
end
