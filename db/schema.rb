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

ActiveRecord::Schema.define(version: 20170903054547) do

  create_table "assignments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.boolean  "accepted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_assignments_on_task_id"
    t.index ["user_id"], name: "index_assignments_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.datetime "event_date"
    t.string   "location"
    t.integer  "repeat",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "event_type"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.string   "group_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.boolean  "trusted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "group_id"], name: "index_memberships_on_user_id_and_group_id", unique: true
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "resolve_link"
    t.boolean  "read",         default: false
    t.datetime "read_time"
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "notifications_users", id: false, force: :cascade do |t|
    t.integer "notification_id", null: false
    t.integer "user_id",         null: false
    t.index ["notification_id"], name: "index_notifications_users_on_notification_id"
    t.index ["user_id"], name: "index_notifications_users_on_user_id"
  end

  create_table "privacy_settings", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "presence",        default: true
    t.boolean  "mobile_number",   default: true
    t.boolean  "address",         default: true
    t.boolean  "email",           default: true
    t.boolean  "dob",             default: true
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "user_created_at", default: true
    t.boolean  "home_number",     default: true
    t.boolean  "work_number",     default: true
    t.index ["user_id"], name: "index_privacy_settings_on_user_id"
  end

  create_table "rosters", force: :cascade do |t|
    t.string   "title"
    t.date     "start_date"
    t.integer  "duration"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "roster_id"
    t.string   "title"
    t.datetime "due"
    t.string   "location"
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "mobile_number"
    t.string   "address"
    t.string   "email"
    t.date     "dob"
    t.string   "password_digest"
    t.string   "level"
    t.boolean  "privacy_consent"
    t.string   "main_service"
    t.text     "special_needs"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "occupation"
    t.text     "notes"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.integer  "home_number"
    t.integer  "work_number"
  end

end
