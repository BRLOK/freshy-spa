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

ActiveRecord::Schema.define(version: 20161212235452) do

  create_table "attendance_items", force: :cascade do |t|
    t.integer  "attendance_id"
    t.integer  "service_id"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.index ["attendance_id"], name: "index_attendance_items_on_attendance_id"
    t.index ["service_id"], name: "index_attendance_items_on_service_id"
  end

  create_table "attendances", force: :cascade do |t|
    t.integer  "customer_id"
    t.datetime "scheduled_for"
    t.string   "status"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.integer  "duration"
    t.index ["customer_id"], name: "index_attendances_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "cpf"
    t.string   "telephone"
    t.boolean  "active",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "duration"
    t.boolean  "active",      default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "services_users", id: false, force: :cascade do |t|
    t.integer "service_id"
    t.integer "user_id"
    t.index ["service_id"], name: "index_services_users_on_service_id"
    t.index ["user_id"], name: "index_services_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "email"
    t.string   "role"
    t.boolean  "active",          default: true
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "auth_token"
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true
  end

end
