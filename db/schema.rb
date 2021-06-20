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

ActiveRecord::Schema.define(version: 2021_06_20_182642) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "asteroids", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_asteroids_on_name", unique: true
  end

  create_table "battles", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "player_limit"
    t.string "state"
    t.index ["player_limit"], name: "index_battles_on_player_limit"
    t.index ["state"], name: "index_battles_on_state"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "state"
    t.string "active_battle_set", default: "default"
    t.index ["name"], name: "index_characters_on_name", unique: true
    t.index ["state"], name: "index_characters_on_state"
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "occupations", force: :cascade do |t|
    t.bigint "character_id"
    t.bigint "occupiable_id"
    t.string "occupiable_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["occupiable_type", "occupiable_id"], name: "index_occupations_on_occupiable_type_and_occupiable_id"
  end

  create_table "participations", force: :cascade do |t|
    t.bigint "character_id"
    t.bigint "participatable_id"
    t.string "participatable_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["participatable_type", "participatable_id"], name: "index_participations_on_participatable_type_and_its_id"
  end

  create_table "planets", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_planets_on_name", unique: true
  end

  create_table "positions", force: :cascade do |t|
    t.bigint "x"
    t.bigint "y"
    t.bigint "positionable_id"
    t.string "positionable_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["positionable_type", "positionable_id"], name: "index_positions_on_positionable_type_and_positionable_id"
  end

  create_table "ships", force: :cascade do |t|
    t.bigint "character_id"
    t.string "battle_set", default: "default"
    t.string "state"
    t.integer "hitpoints"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stars", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_stars_on_name", unique: true
  end

  create_table "stations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_stations_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "online", default: false
    t.datetime "last_online"
    t.string "google_id"
    t.string "email"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["google_id"], name: "index_users_on_google_id", unique: true
  end

end
