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

ActiveRecord::Schema[7.0].define(version: 2023_03_28_005352) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendships", force: :cascade do |t|
    t.integer "todo_user_id"
    t.integer "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accepted", default: false
    t.integer "creator_id"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "todo_tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "reminder"
    t.date "deadline"
    t.boolean "finished"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "isAnytime", default: false
    t.bigint "creator_id", null: false
    t.index ["creator_id"], name: "index_todo_tasks_on_creator_id"
  end

  create_table "todo_tasks_users", id: false, force: :cascade do |t|
    t.bigint "todo_task_id", null: false
    t.bigint "todo_user_id", null: false
    t.index ["todo_task_id"], name: "index_todo_tasks_users_on_todo_task_id"
    t.index ["todo_user_id"], name: "index_todo_tasks_users_on_todo_user_id"
  end

  create_table "todo_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_todo_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_todo_users_on_reset_password_token", unique: true
  end

  add_foreign_key "todo_tasks", "todo_users", column: "creator_id"
end
