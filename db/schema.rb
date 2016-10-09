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

ActiveRecord::Schema.define(version: 20161009213234) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "full_name"
    t.string   "ic_number"
    t.string   "phone_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "staff_groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "staff_zone_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "staff_zones", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "state_configs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "state_id"
    t.integer  "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "state_configs", ["state_id"], name: "index_state_configs_on_state_id", using: :btree
  add_index "state_configs", ["user_id"], name: "index_state_configs_on_user_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "system_preferences", force: :cascade do |t|
    t.datetime "start_window"
    t.datetime "end_window"
    t.integer  "player_reg_limit"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "team_configs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "state_id"
    t.string   "team_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "team_configs", ["state_id"], name: "index_team_configs_on_state_id", using: :btree
  add_index "team_configs", ["user_id"], name: "index_team_configs_on_user_id", using: :btree

  create_table "team_officials", force: :cascade do |t|
    t.integer  "team_id"
    t.string   "name"
    t.string   "position"
    t.string   "phone_number"
    t.string   "ic_number"
    t.string   "email_address"
    t.string   "no_sijil"
    t.string   "salinan_sijil"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "profile_picture"
    t.string   "ref_id"
  end

  add_index "team_officials", ["ref_id"], name: "index_team_officials_on_ref_id", unique: true, using: :btree
  add_index "team_officials", ["team_id"], name: "index_team_officials_on_team_id", using: :btree

  create_table "team_players", force: :cascade do |t|
    t.integer  "team_id"
    t.string   "player_name"
    t.string   "player_picture"
    t.string   "ic_number"
    t.string   "ic_picture"
    t.datetime "dob"
    t.string   "position"
    t.integer  "jersey_no"
    t.integer  "status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "ref_id"
  end

  add_index "team_players", ["ic_number"], name: "index_team_players_on_ic_number", unique: true, using: :btree
  add_index "team_players", ["ref_id"], name: "index_team_players_on_ref_id", unique: true, using: :btree
  add_index "team_players", ["team_id"], name: "index_team_players_on_team_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "state_id"
    t.string   "team_name"
    t.string   "team_ref_id"
    t.integer  "admin_officer_id"
    t.string   "phone_number"
    t.string   "team_email_address"
    t.text     "address"
    t.string   "team_logo"
    t.string   "team_image"
    t.integer  "status"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "teams", ["admin_officer_id"], name: "index_teams_on_admin_officer_id", using: :btree
  add_index "teams", ["state_id"], name: "index_teams_on_state_id", using: :btree
  add_index "teams", ["user_id"], name: "index_teams_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "username",               default: "", null: false
    t.integer  "role",                   default: 0
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "state_id"
    t.string   "team_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["state_id"], name: "index_users_on_state_id", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "profiles", "users"
  add_foreign_key "state_configs", "states"
  add_foreign_key "state_configs", "users"
  add_foreign_key "team_configs", "states"
  add_foreign_key "team_configs", "users"
  add_foreign_key "team_officials", "teams"
  add_foreign_key "team_players", "teams"
  add_foreign_key "teams", "states"
  add_foreign_key "teams", "users"
  add_foreign_key "users", "states"
end
