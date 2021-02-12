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

ActiveRecord::Schema.define(version: 2021_02_11_025433) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "employees", primary_key: "employee_id", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "employer_id"
    t.string "employee_position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_employees_on_employee_id"
  end

  create_table "employers", primary_key: "employer_id", id: :serial, force: :cascade do |t|
    t.string "employer_description"
    t.string "employer_industry"
    t.string "employer_website_url"
    t.string "employer_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employer_id"], name: "index_employers_on_employer_id"
  end

  create_table "user_profiles", primary_key: "user_id", id: :serial, force: :cascade do |t|
    t.string "user_email"
    t.boolean "user_display_email_status"
    t.boolean "user_current_member_status"
    t.string "user_facebook_profile_url"
    t.string "user_instagram_profile_url"
    t.string "user_linkedin_profile_url"
    t.integer "user_graduating_year"
    t.string "user_about_me_description"
    t.string "user_phone_number"
    t.string "user_first_name"
    t.string "user_last_name"
    t.string "user_portfolio_url"
    t.string "user_profile_picture_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", primary_key: "user_email", id: :string, force: :cascade do |t|
    t.boolean "admin_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_email"], name: "index_users_on_user_email"
  end

  add_foreign_key "employees", "employers", primary_key: "employer_id"
  add_foreign_key "employees", "user_profiles", column: "user_id", primary_key: "user_id"
  add_foreign_key "user_profiles", "users", column: "user_email", primary_key: "user_email"
end
