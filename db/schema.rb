# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150312150604) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collaborators", force: :cascade do |t|
    t.string  "role"
    t.boolean "owner",      default: false, null: false
    t.integer "user_id"
    t.integer "project_id"
  end

  add_index "collaborators", ["project_id"], name: "index_collaborators_on_project_id", using: :btree
  add_index "collaborators", ["user_id"], name: "index_collaborators_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text    "body"
    t.integer "task_id"
    t.integer "user_id"
  end

  add_index "comments", ["task_id"], name: "index_comments_on_task_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "files", force: :cascade do |t|
    t.string   "name"
    t.string   "url",        null: false
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "files", ["task_id"], name: "index_files_on_task_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "project_title",                   null: false
    t.text     "description"
    t.datetime "start_date",                      null: false
    t.datetime "due_date"
    t.datetime "completion_date"
    t.boolean  "completed",       default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: :cascade do |t|
    t.datetime "due_date"
    t.boolean  "completed",   default: false, null: false
    t.integer  "priority",    default: 0,     null: false
    t.string   "title",                       null: false
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id", using: :btree

  create_table "user_tasks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "task_id"
  end

  add_index "user_tasks", ["task_id"], name: "index_user_tasks_on_task_id", using: :btree
  add_index "user_tasks", ["user_id"], name: "index_user_tasks_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "user_name",       null: false
    t.string   "email",           null: false
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "password_digest", null: false
    t.string   "image_url"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "collaborators", "projects"
  add_foreign_key "collaborators", "users"
  add_foreign_key "comments", "tasks"
  add_foreign_key "comments", "users"
  add_foreign_key "files", "tasks"
  add_foreign_key "tasks", "projects"
  add_foreign_key "user_tasks", "tasks"
  add_foreign_key "user_tasks", "users"
end
