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

ActiveRecord::Schema.define(version: 20150615181200) do

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "role"
    t.string   "description"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.integer  "owner_id"
  end

  create_table "sub_tasks", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "done"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_tags", force: :cascade do |t|
    t.integer  "task_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "task_tags", ["tag_id"], name: "index_task_tags_on_tag_id"
  add_index "task_tags", ["task_id", "tag_id"], name: "index_task_tags_on_task_id_and_tag_id", unique: true
  add_index "task_tags", ["task_id"], name: "index_task_tags_on_task_id"

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "done"
    t.integer  "complexity",  default: 1
    t.integer  "est_time"
    t.integer  "actual_time"
  end

end
