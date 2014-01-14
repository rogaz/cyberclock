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

ActiveRecord::Schema.define(version: 20140114041442) do

  create_table "branches", force: true do |t|
    t.string   "name"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "branches", ["company_id"], name: "index_branches_on_company_id"

  create_table "companies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "computers", force: true do |t|
    t.string   "name"
    t.integer  "branch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "computers", ["branch_id"], name: "index_computers_on_branch_id"

  create_table "promotions", force: true do |t|
    t.string   "description"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "promotions", ["company_id"], name: "index_promotions_on_company_id"

  create_table "rents", force: true do |t|
    t.string   "name"
    t.time     "duration"
    t.string   "rent_type"
    t.integer  "computer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rents", ["computer_id"], name: "index_rents_on_computer_id"

  create_table "rules", force: true do |t|
    t.text     "description"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rules", ["company_id"], name: "index_rules_on_company_id"

end
