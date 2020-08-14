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

ActiveRecord::Schema.define(version: 2020_08_14_021211) do

  create_table "names", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.string "name"
    t.string "player"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
  end

  create_table "proper_names", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "proper_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_proper_names_on_name"
    t.index ["proper_id"], name: "index_proper_names_on_proper_id"
  end

  create_table "statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.integer "clv"
    t.integer "ikki"
    t.integer "guardian_id"
    t.integer "cp"
    t.integer "ps"
    t.integer "mhp"
    t.integer "msp"
    t.integer "psp"
    t.integer "str"
    t.integer "vit"
    t.integer "tec"
    t.integer "int"
    t.integer "mnd"
    t.integer "agi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agi"], name: "index_statuses_on_agi"
    t.index ["clv"], name: "index_statuses_on_clv"
    t.index ["cp"], name: "index_statuses_on_cp"
    t.index ["guardian_id"], name: "index_statuses_on_guardian_id"
    t.index ["ikki"], name: "index_statuses_on_ikki"
    t.index ["int"], name: "index_statuses_on_int"
    t.index ["mhp"], name: "index_statuses_on_mhp"
    t.index ["mnd"], name: "index_statuses_on_mnd"
    t.index ["msp"], name: "index_statuses_on_msp"
    t.index ["ps"], name: "index_statuses_on_ps"
    t.index ["psp"], name: "index_statuses_on_psp"
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
    t.index ["str"], name: "index_statuses_on_str"
    t.index ["tec"], name: "index_statuses_on_tec"
    t.index ["vit"], name: "index_statuses_on_vit"
  end

  create_table "uploaded_checks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["result_no", "generate_no"], name: "resultno_generateno"
  end

end
