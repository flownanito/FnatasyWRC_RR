# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2026_07_08_055405) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "cars", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.integer "performance_bonus"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "team_id"
    t.index ["team_id"], name: "index_cars_on_team_id"
  end

  create_table "drivers", force: :cascade do |t|
    t.string "name"
    t.integer "category"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "team_id"
    t.string "image_url"
    t.integer "overall_rating"
    t.integer "pace"
    t.integer "consistency"
    t.integer "experience"
    t.integer "participation"
    t.index ["team_id"], name: "index_drivers_on_team_id"
  end

  create_table "engineers", force: :cascade do |t|
    t.string "name"
    t.integer "specialty"
    t.decimal "price"
    t.decimal "bonus_multiplier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fantasy_lineups", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "rally_id", null: false
    t.integer "driver1_id"
    t.integer "driver2_id"
    t.integer "car_id", null: false
    t.integer "engineer_id", null: false
    t.integer "sponsor_id", null: false
    t.integer "total_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "league_id", null: false
    t.index ["car_id"], name: "index_fantasy_lineups_on_car_id"
    t.index ["engineer_id"], name: "index_fantasy_lineups_on_engineer_id"
    t.index ["league_id"], name: "index_fantasy_lineups_on_league_id"
    t.index ["rally_id"], name: "index_fantasy_lineups_on_rally_id"
    t.index ["sponsor_id"], name: "index_fantasy_lineups_on_sponsor_id"
    t.index ["user_id"], name: "index_fantasy_lineups_on_user_id"
  end

  create_table "league_drivers", force: :cascade do |t|
    t.integer "league_id", null: false
    t.integer "driver_id", null: false
    t.integer "user_id"
    t.decimal "release_clause"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_league_drivers_on_driver_id"
    t.index ["league_id"], name: "index_league_drivers_on_league_id"
    t.index ["user_id"], name: "index_league_drivers_on_user_id"
  end

  create_table "league_members", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "league_id", null: false
    t.integer "total_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "budget", default: "100000000.0"
    t.index ["league_id"], name: "index_league_members_on_league_id"
    t.index ["user_id"], name: "index_league_members_on_user_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_leagues_on_owner_id"
  end

  create_table "official_driver_results", force: :cascade do |t|
    t.integer "rally_id", null: false
    t.integer "driver_id", null: false
    t.integer "position"
    t.integer "points_earned"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "power_stage_position"
    t.index ["driver_id"], name: "index_official_driver_results_on_driver_id"
    t.index ["rally_id"], name: "index_official_driver_results_on_rally_id"
  end

  create_table "rallies", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.integer "surface"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date"
    t.date "end_date"
  end

  create_table "sponsors", force: :cascade do |t|
    t.string "name"
    t.decimal "monetary_reward"
    t.string "condition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stages", force: :cascade do |t|
    t.integer "rally_id", null: false
    t.string "name"
    t.decimal "length_km"
    t.string "surface_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rally_id"], name: "index_stages_on_rally_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "username"
    t.integer "points", default: 0
    t.decimal "budget", default: "100000000.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "locale", default: "es"
    t.string "theme", default: "dark"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cars", "teams"
  add_foreign_key "drivers", "teams"
  add_foreign_key "fantasy_lineups", "cars"
  add_foreign_key "fantasy_lineups", "engineers"
  add_foreign_key "fantasy_lineups", "leagues"
  add_foreign_key "fantasy_lineups", "rallies"
  add_foreign_key "fantasy_lineups", "sponsors"
  add_foreign_key "fantasy_lineups", "users"
  add_foreign_key "league_drivers", "drivers"
  add_foreign_key "league_drivers", "leagues"
  add_foreign_key "league_drivers", "users"
  add_foreign_key "league_members", "leagues"
  add_foreign_key "league_members", "users"
  add_foreign_key "leagues", "users", column: "owner_id"
  add_foreign_key "official_driver_results", "drivers"
  add_foreign_key "official_driver_results", "rallies"
  add_foreign_key "stages", "rallies"
  add_foreign_key "teams", "users"
end
