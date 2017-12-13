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

ActiveRecord::Schema.define(version: 20171213130433) do

  create_table "contractors", force: :cascade do |t|
    t.string   "phone"
    t.string   "name"
    t.text     "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email"
  end

  create_table "maintenances", force: :cascade do |t|
    t.string   "worktype"
    t.decimal  "cost"
    t.text     "details"
    t.date     "date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "contractor_id"
    t.integer  "property_id"
    t.index ["contractor_id"], name: "index_maintenances_on_contractor_id"
    t.index ["property_id"], name: "index_maintenances_on_property_id"
  end

  create_table "people", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "phone"
    t.decimal  "participation"
    t.date     "joined"
    t.date     "exit"
    t.boolean  "member",        default: false
    t.boolean  "housed",        default: true
    t.boolean  "secretary",     default: true
    t.boolean  "rent_officer",  default: true
    t.boolean  "admin",         default: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "property_id"
    t.text     "words"
    t.index ["property_id"], name: "index_people_on_property_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string   "house_name_no"
    t.string   "address1"
    t.string   "address2"
    t.string   "postcode"
    t.decimal  "rent_per_week"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
