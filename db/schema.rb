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

ActiveRecord::Schema.define(version: 20171216030605) do

  create_table "appraises", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "desc"
    t.integer "publish_status"
    t.integer "position_id"
    t.float "score", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "level"
    t.string "gender", limit: 11
    t.string "identification"
    t.integer "age"
  end

  create_table "licenses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "content"
    t.integer "is_used"
    t.integer "position_id"
    t.integer "license_type"
    t.string "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "publish_status"
  end

  create_table "position_employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "postion_id"
    t.integer "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "position_relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "entity_id"
    t.integer "relationship_type"
    t.integer "position_id"
  end

  create_table "positions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "desc"
    t.integer "publish_status"
    t.integer "team_id"
    t.integer "position_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "weight", limit: 24
    t.float "position_weight", limit: 24
    t.float "employee_weight", limit: 24
  end

  create_table "scores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "position_id"
    t.integer "score"
    t.integer "license_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "entity_id"
    t.string "entity_type"
  end

  create_table "teams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "desc"
    t.integer "publish_status"
    t.integer "parent_team_id"
    t.integer "team_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
