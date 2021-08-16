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

ActiveRecord::Schema.define(version: 2021_08_16_192206) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "purchase_data", force: :cascade do |t|
    t.string "cpf"
    t.integer "private_purchase"
    t.integer "incomplete"
    t.datetime "date_of_last_purchase"
    t.float "average_ticket"
    t.float "last_purchase_ticket"
    t.string "most_frequent_store"
    t.string "last_purchase_store"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
