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

ActiveRecord::Schema[7.1].define(version: 2024_01_04_192128) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dashboard_academic_years", force: :cascade do |t|
    t.string "range"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["range"], name: "index_dashboard_academic_years_on_range", unique: true
  end

  create_table "dashboard_admin_data_items", force: :cascade do |t|
    t.string "admin_data_item_id"
    t.string "description"
    t.float "watch_low_benchmark"
    t.float "growth_low_benchmark"
    t.float "approval_low_benchmark"
    t.float "ideal_low_benchmark"
    t.boolean "hs_only_item"
    t.bigint "dashboard_scale_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_scale_id"], name: "index_dashboard_admin_data_items_on_dashboard_scale_id"
  end

  create_table "dashboard_admin_data_values", force: :cascade do |t|
    t.float "likert_score"
    t.bigint "dashboard_school_id", null: false
    t.bigint "dashboard_admin_data_item_id", null: false
    t.bigint "dashboard_academic_year_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_academic_year_id"], name: "idx_on_dashboard_academic_year_id_1de27231d5"
    t.index ["dashboard_admin_data_item_id", "dashboard_school_id", "dashboard_academic_year_id"], name: "idx_on_dashboard_admin_data_item_id_dashboard_schoo_4a9c27f1d0", unique: true
    t.index ["dashboard_admin_data_item_id"], name: "idx_on_dashboard_admin_data_item_id_edae2faad3"
    t.index ["dashboard_school_id"], name: "index_dashboard_admin_data_values_on_dashboard_school_id"
  end

  create_table "dashboard_categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "slug"
    t.string "category_id"
    t.string "short_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dashboard_districts", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.integer "qualtrics_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dashboard_ells", force: :cascade do |t|
    t.string "designation"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dashboard_genders", force: :cascade do |t|
    t.integer "qualtrics_code"
    t.string "designation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dashboard_incomes", force: :cascade do |t|
    t.string "designation"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dashboard_measures", force: :cascade do |t|
    t.string "measure_id"
    t.string "name"
    t.bigint "dashboard_subcategory_id", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_subcategory_id"], name: "index_dashboard_measures_on_dashboard_subcategory_id"
  end

  create_table "dashboard_races", force: :cascade do |t|
    t.string "designation"
    t.integer "qualtrics_code"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dashboard_respondents", force: :cascade do |t|
    t.bigint "dashboard_school_id", null: false
    t.bigint "dashboard_academic_year_id", null: false
    t.integer "total_students"
    t.float "total_teachers"
    t.integer "pk"
    t.integer "k"
    t.integer "one"
    t.integer "two"
    t.integer "three"
    t.integer "four"
    t.integer "five"
    t.integer "six"
    t.integer "seven"
    t.integer "eight"
    t.integer "nine"
    t.integer "ten"
    t.integer "eleven"
    t.integer "twelve"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_academic_year_id"], name: "index_dashboard_respondents_on_dashboard_academic_year_id"
    t.index ["dashboard_school_id", "dashboard_academic_year_id"], name: "idx_on_dashboard_school_id_dashboard_academic_year__17920cd0dd", unique: true
    t.index ["dashboard_school_id"], name: "index_dashboard_respondents_on_dashboard_school_id"
  end

  create_table "dashboard_response_rates", force: :cascade do |t|
    t.bigint "dashboard_subcategory_id", null: false
    t.bigint "dashboard_school_id", null: false
    t.bigint "dashboard_academic_year_id", null: false
    t.float "student_response_rate"
    t.float "teacher_response_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_academic_year_id"], name: "index_dashboard_response_rates_on_dashboard_academic_year_id"
    t.index ["dashboard_school_id"], name: "index_dashboard_response_rates_on_dashboard_school_id"
    t.index ["dashboard_subcategory_id"], name: "index_dashboard_response_rates_on_dashboard_subcategory_id"
  end

  create_table "dashboard_scales", force: :cascade do |t|
    t.string "scale_id"
    t.bigint "dashboard_measure_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_measure_id"], name: "index_dashboard_scales_on_dashboard_measure_id"
  end

  create_table "dashboard_schools", force: :cascade do |t|
    t.string "name"
    t.bigint "dashboard_district_id", null: false
    t.string "slug"
    t.integer "qualtrics_code"
    t.integer "dese_id"
    t.boolean "is_hs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_district_id"], name: "index_dashboard_schools_on_dashboard_district_id"
    t.index ["dese_id"], name: "index_dashboard_schools_on_dese_id", unique: true
  end

  create_table "dashboard_scores", force: :cascade do |t|
    t.float "average"
    t.boolean "meets_teacher_threshold"
    t.boolean "meets_student_threshold"
    t.boolean "meets_admin_data_threshold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dashboard_speds", force: :cascade do |t|
    t.string "designation"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dashboard_student_races", force: :cascade do |t|
    t.bigint "dashboard_student_id", null: false
    t.bigint "dashboard_race_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_race_id"], name: "index_dashboard_student_races_on_dashboard_race_id"
    t.index ["dashboard_student_id"], name: "index_dashboard_student_races_on_dashboard_student_id"
  end

  create_table "dashboard_students", force: :cascade do |t|
    t.string "lasid"
    t.string "response_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dashboard_subcategories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "subcategory_id"
    t.bigint "dashboard_categories_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_categories_id"], name: "index_dashboard_subcategories_on_dashboard_categories_id"
  end

  create_table "dashboard_survey_item_responses", force: :cascade do |t|
    t.integer "likert_score"
    t.bigint "dashboard_school_id", null: false
    t.bigint "dashboard_survey_item_id", null: false
    t.bigint "dashboard_academic_year_id", null: false
    t.bigint "dashboard_student_id"
    t.bigint "dashboard_gender_id"
    t.bigint "dashboard_income_id"
    t.bigint "dashboard_ell_id"
    t.bigint "dashboard_sped_id"
    t.string "response_id"
    t.integer "grade"
    t.datetime "recorded_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_academic_year_id"], name: "idx_on_dashboard_academic_year_id_98a9cc7783"
    t.index ["dashboard_ell_id"], name: "index_dashboard_survey_item_responses_on_dashboard_ell_id"
    t.index ["dashboard_gender_id"], name: "index_dashboard_survey_item_responses_on_dashboard_gender_id"
    t.index ["dashboard_income_id"], name: "index_dashboard_survey_item_responses_on_dashboard_income_id"
    t.index ["dashboard_school_id", "dashboard_academic_year_id"], name: "idx_on_dashboard_school_id_dashboard_academic_year__44af844634"
    t.index ["dashboard_school_id"], name: "index_dashboard_survey_item_responses_on_dashboard_school_id"
    t.index ["dashboard_sped_id"], name: "index_dashboard_survey_item_responses_on_dashboard_sped_id"
    t.index ["dashboard_student_id"], name: "index_dashboard_survey_item_responses_on_dashboard_student_id"
    t.index ["dashboard_survey_item_id"], name: "idx_on_dashboard_survey_item_id_3f6652fbc6"
    t.index ["response_id", "dashboard_school_id", "dashboard_academic_year_id", "dashboard_survey_item_id"], name: "idx_on_response_id_dashboard_school_id_dashboard_ac_5b0b3359c0", unique: true
  end

  create_table "dashboard_survey_items", force: :cascade do |t|
    t.string "survey_item_id"
    t.string "prompt"
    t.float "watch_low_benchmark"
    t.float "growth_low_benchmark"
    t.float "approval_low_benchmark"
    t.float "ideal_low_benchmark"
    t.bigint "dashboard_scale_id", null: false
    t.boolean "on_short_form"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_scale_id"], name: "index_dashboard_survey_items_on_dashboard_scale_id"
  end

  add_foreign_key "dashboard_admin_data_items", "dashboard_scales"
  add_foreign_key "dashboard_admin_data_values", "dashboard_academic_years"
  add_foreign_key "dashboard_admin_data_values", "dashboard_admin_data_items"
  add_foreign_key "dashboard_admin_data_values", "dashboard_schools"
  add_foreign_key "dashboard_measures", "dashboard_subcategories"
  add_foreign_key "dashboard_respondents", "dashboard_academic_years"
  add_foreign_key "dashboard_respondents", "dashboard_schools"
  add_foreign_key "dashboard_response_rates", "dashboard_academic_years"
  add_foreign_key "dashboard_response_rates", "dashboard_schools"
  add_foreign_key "dashboard_response_rates", "dashboard_subcategories"
  add_foreign_key "dashboard_scales", "dashboard_measures"
  add_foreign_key "dashboard_schools", "dashboard_districts"
  add_foreign_key "dashboard_student_races", "dashboard_races"
  add_foreign_key "dashboard_student_races", "dashboard_students"
  add_foreign_key "dashboard_subcategories", "dashboard_categories", column: "dashboard_categories_id"
  add_foreign_key "dashboard_survey_item_responses", "dashboard_academic_years"
  add_foreign_key "dashboard_survey_item_responses", "dashboard_ells"
  add_foreign_key "dashboard_survey_item_responses", "dashboard_genders"
  add_foreign_key "dashboard_survey_item_responses", "dashboard_incomes"
  add_foreign_key "dashboard_survey_item_responses", "dashboard_schools"
  add_foreign_key "dashboard_survey_item_responses", "dashboard_speds"
  add_foreign_key "dashboard_survey_item_responses", "dashboard_students"
  add_foreign_key "dashboard_survey_item_responses", "dashboard_survey_items"
  add_foreign_key "dashboard_survey_items", "dashboard_scales"
end
