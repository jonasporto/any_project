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

ActiveRecord::Schema.define(version: 2021_10_26_205446) do

  create_table "shortener_link_visitors", force: :cascade do |t|
    t.string "referrer"
    t.string "ip_address"
    t.string "session_id"
    t.integer "shortener_link_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shortener_link_id"], name: "index_shortener_link_visitors_on_shortener_link_id"
  end

  create_table "shortener_links", force: :cascade do |t|
    t.text "long_url", null: false
    t.text "token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["long_url"], name: "index_shortener_links_on_long_url"
    t.index ["token"], name: "index_shortener_links_on_token"
  end

  add_foreign_key "shortener_link_visitors", "shortener_links"
end
