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

ActiveRecord::Schema.define(version: 2019_03_11_002911) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "readings", force: :cascade do |t|
    t.bigint "thermostat_id"
    t.integer "number", default: 0
    t.float "temperature", default: 0.0
    t.float "humidity", default: 0.0
    t.float "battery_charge", default: 0.0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["thermostat_id", "number"], name: "index_readings_on_thermostat_id_and_number", unique: true
  end

  create_table "thermostats", force: :cascade do |t|
    t.text "household_token"
    t.text "location", default: ""
    t.integer "counter", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["household_token"], name: "index_thermostats_on_household_token", unique: true
  end

end
