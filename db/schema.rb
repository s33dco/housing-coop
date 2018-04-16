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

ActiveRecord::Schema.define(version: 20180415201002) do

  create_table "calendars", force: :cascade do |t|
    t.datetime "date_time"
    t.string "where"
    t.string "title"
    t.text "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link"
  end

  create_table "contractors", force: :cascade do |t|
    t.string "phone"
    t.string "name"
    t.text "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.text "notes"
    t.boolean "use"
    t.string "slug"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
  end

  create_table "maintenances", force: :cascade do |t|
    t.decimal "cost"
    t.text "details"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "contractor_id"
    t.integer "property_id"
    t.integer "worktype_id"
    t.index ["contractor_id"], name: "index_maintenances_on_contractor_id"
    t.index ["property_id"], name: "index_maintenances_on_property_id"
    t.index ["worktype_id"], name: "index_maintenances_on_worktype_id"
  end

  create_table "participations", force: :cascade do |t|
    t.integer "person_id"
    t.integer "calendar_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["calendar_id"], name: "index_participations_on_calendar_id"
    t.index ["person_id"], name: "index_participations_on_person_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "phone"
    t.decimal "participation"
    t.date "joined"
    t.date "exit"
    t.boolean "member", default: false
    t.boolean "housed", default: true
    t.boolean "secretary", default: true
    t.boolean "rent_officer", default: true
    t.boolean "admin", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "property_id"
    t.text "words"
    t.boolean "child"
    t.string "slug"
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.boolean "maintenance"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["email"], name: "index_people_on_email", unique: true
    t.index ["property_id"], name: "index_people_on_property_id"
    t.index ["reset_password_token"], name: "index_people_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_people_on_unlock_token", unique: true
  end

  create_table "properties", force: :cascade do |t|
    t.string "name_or_number"
    t.string "address1"
    t.string "address2"
    t.string "postcode"
    t.decimal "rent_per_week"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "kitchen_upgrade"
    t.boolean "coop_house"
    t.decimal "new_rent_value"
    t.date "first_day_of_next_rent_period"
    t.date "rent_period_start"
    t.date "moving_out_date"
    t.decimal "rent_balance", default: "0.0"
    t.datetime "balance_created"
    t.decimal "end_of_tenancy"
    t.string "slug"
  end

  create_table "rents", force: :cascade do |t|
    t.integer "property_id"
    t.decimal "payment"
    t.date "date"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_rents_on_property_id"
  end

  create_table "roles", force: :cascade do |t|
    t.integer "person_id"
    t.integer "job_id"
    t.date "role_start"
    t.date "role_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_roles_on_job_id"
    t.index ["person_id"], name: "index_roles_on_person_id"
  end

  create_table "worktypes", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
