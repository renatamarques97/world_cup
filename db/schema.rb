# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_11_185849) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "group_rankings", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_group_rankings_on_group_id"
    t.index ["team_id"], name: "index_group_rankings_on_team_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "tournament_id", null: false
    t.index ["tournament_id"], name: "index_groups_on_tournament_id"
  end

  create_table "match_results", force: :cascade do |t|
    t.string "result", null: false
    t.integer "goals", null: false
    t.bigint "team_id", null: false
    t.bigint "match_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["match_id"], name: "index_match_results_on_match_id"
    t.index ["team_id"], name: "index_match_results_on_team_id"
  end

  create_table "matches", force: :cascade do |t|
    t.boolean "played"
    t.bigint "team_a_id", null: false
    t.bigint "team_b_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phase"
    t.bigint "tournament_id", null: false
    t.index ["team_a_id"], name: "index_matches_on_team_a_id"
    t.index ["team_b_id"], name: "index_matches_on_team_b_id"
    t.index ["tournament_id"], name: "index_matches_on_tournament_id"
  end

  create_table "overall_rankings", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "tournament_id", null: false
    t.bigint "team_id", null: false
    t.integer "position"
    t.index ["team_id"], name: "index_overall_rankings_on_team_id"
    t.index ["tournament_id"], name: "index_overall_rankings_on_tournament_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.bigint "group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "tournament_id"
    t.index ["group_id"], name: "index_teams_on_group_id"
    t.index ["tournament_id"], name: "index_teams_on_tournament_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.string "state", default: "none"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "group_rankings", "groups"
  add_foreign_key "group_rankings", "teams"
  add_foreign_key "groups", "tournaments"
  add_foreign_key "match_results", "matches"
  add_foreign_key "match_results", "teams"
  add_foreign_key "matches", "teams", column: "team_a_id"
  add_foreign_key "matches", "teams", column: "team_b_id"
  add_foreign_key "matches", "tournaments"
  add_foreign_key "overall_rankings", "teams"
  add_foreign_key "overall_rankings", "tournaments"
  add_foreign_key "teams", "groups"
  add_foreign_key "teams", "tournaments"
end
