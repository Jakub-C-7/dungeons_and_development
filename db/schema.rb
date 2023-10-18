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

ActiveRecord::Schema[7.1].define(version: 2023_10_18_150419) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "interests", force: :cascade do |t|
    t.string "name"
    t.boolean "isRole"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pathway_interests", force: :cascade do |t|
    t.bigint "pathway_id", null: false
    t.bigint "interest_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interest_id"], name: "index_pathway_interests_on_interest_id"
    t.index ["pathway_id", "interest_id"], name: "index_pathway_interests_on_pathway_id_and_interest_id", unique: true
    t.index ["pathway_id"], name: "index_pathway_interests_on_pathway_id"
  end

  create_table "pathway_sections", force: :cascade do |t|
    t.bigint "section_id", null: false
    t.bigint "pathway_id", null: false
    t.integer "step_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pathway_id"], name: "index_pathway_sections_on_pathway_id"
    t.index ["section_id", "pathway_id"], name: "index_pathway_sections_on_section_id_and_pathway_id", unique: true
    t.index ["section_id"], name: "index_pathway_sections_on_section_id"
  end

  create_table "pathways", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "section_interests", force: :cascade do |t|
    t.bigint "section_id", null: false
    t.bigint "interest_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interest_id"], name: "index_section_interests_on_interest_id"
    t.index ["section_id", "interest_id"], name: "index_section_interests_on_section_id_and_interest_id", unique: true
    t.index ["section_id"], name: "index_section_interests_on_section_id"
  end

  create_table "section_tasks", force: :cascade do |t|
    t.bigint "section_id", null: false
    t.bigint "task_id", null: false
    t.integer "step_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id", "task_id"], name: "index_section_tasks_on_section_id_and_task_id", unique: true
    t.index ["section_id"], name: "index_section_tasks_on_section_id"
    t.index ["task_id"], name: "index_section_tasks_on_task_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_interests", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "interest_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interest_id"], name: "index_task_interests_on_interest_id"
    t.index ["task_id", "interest_id"], name: "index_task_interests_on_task_id_and_interest_id", unique: true
    t.index ["task_id"], name: "index_task_interests_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_interests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "interest_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "isPrimaryRole", default: false
    t.index ["interest_id"], name: "index_user_interests_on_interest_id"
    t.index ["user_id", "interest_id"], name: "unique_interest_per_user", unique: true
    t.index ["user_id"], name: "index_user_interests_on_user_id"
  end

  create_table "user_tasks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "task_id", null: false
    t.integer "progress"
    t.datetime "last_updated"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_user_tasks_on_task_id"
    t.index ["user_id", "task_id"], name: "index_user_tasks_on_user_id_and_task_id", unique: true
    t.index ["user_id"], name: "index_user_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "pathway_interests", "interests"
  add_foreign_key "pathway_interests", "pathways"
  add_foreign_key "pathway_sections", "pathways"
  add_foreign_key "pathway_sections", "sections"
  add_foreign_key "section_interests", "interests"
  add_foreign_key "section_interests", "sections"
  add_foreign_key "section_tasks", "sections"
  add_foreign_key "section_tasks", "tasks"
  add_foreign_key "task_interests", "interests"
  add_foreign_key "task_interests", "tasks"
  add_foreign_key "user_interests", "interests"
  add_foreign_key "user_interests", "users"
  add_foreign_key "user_tasks", "tasks"
  add_foreign_key "user_tasks", "users"
end
