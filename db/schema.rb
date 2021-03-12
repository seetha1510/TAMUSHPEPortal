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

ActiveRecord::Schema.define(version: 2021_03_11_204938) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  end

  create_table "employees", force: :cascade do |t|
    t.integer "user_profile_id"
    t.integer "employer_id"
    t.string "employee_position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_profile_id", "employer_id", "employee_position"], name: "employed", unique: true
  end

  create_table "employers", force: :cascade do |t|
    t.string "employer_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employer_name"], name: "index_employers_on_employer_name"
  end

  create_table "schools", force: :cascade do |t|
    t.string "school_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["school_name"], name: "index_schools_on_school_name"
  end

  create_table "students", force: :cascade do |t|
    t.integer "user_profile_id"
    t.integer "school_id"
    t.string "student_degree"
    t.string "student_field_of_study"
    t.datetime "degree_start_date"
    t.datetime "degree_end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_profiles", force: :cascade do |t|
    t.integer "user_id"
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
  end

  create_table "users", force: :cascade do |t|
    t.string "user_email", null: false
    t.boolean "admin_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_email"], name: "index_users_on_user_email"
  end

  add_foreign_key "employees", "employers"
  add_foreign_key "employees", "user_profiles"
  add_foreign_key "students", "schools"
  add_foreign_key "students", "user_profiles"
  add_foreign_key "user_profiles", "users"
end
