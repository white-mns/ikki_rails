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

ActiveRecord::Schema.define(version: 2020_08_17_062528) do

  create_table "embryo_names", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "embryo_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["embryo_id"], name: "index_embryo_names_on_embryo_id"
    t.index ["name"], name: "index_embryo_names_on_name"
  end

  create_table "embryos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.integer "order"
    t.integer "embryo_id"
    t.integer "is_physics"
    t.integer "lv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["embryo_id"], name: "index_embryos_on_embryo_id"
    t.index ["is_physics"], name: "index_embryos_on_is_physics"
    t.index ["lv"], name: "index_embryos_on_lv"
    t.index ["order"], name: "index_embryos_on_order"
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
  end

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

  create_table "productions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.integer "cook"
    t.integer "make"
    t.integer "composition"
    t.integer "addition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addition"], name: "index_productions_on_addition"
    t.index ["composition"], name: "index_productions_on_composition"
    t.index ["cook"], name: "index_productions_on_cook"
    t.index ["make"], name: "index_productions_on_make"
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

  create_table "skill_data", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "skill_id"
    t.string "name"
    t.integer "embryo_id"
    t.integer "is_physics"
    t.integer "lv"
    t.integer "sp"
    t.integer "gift_id"
    t.integer "gp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["embryo_id"], name: "index_skill_data_on_embryo_id"
    t.index ["gift_id"], name: "index_skill_data_on_gift_id"
    t.index ["gp"], name: "index_skill_data_on_gp"
    t.index ["is_physics"], name: "index_skill_data_on_is_physics"
    t.index ["lv"], name: "index_skill_data_on_lv"
    t.index ["name"], name: "index_skill_data_on_name"
    t.index ["skill_id"], name: "index_skill_data_on_skill_id"
    t.index ["sp"], name: "index_skill_data_on_sp"
  end

  create_table "skills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "result_no"
    t.integer "generate_no"
    t.integer "e_no"
    t.integer "order"
    t.integer "skill_id"
    t.integer "gift_open"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gift_open"], name: "index_skills_on_gift_open"
    t.index ["order"], name: "index_skills_on_order"
    t.index ["result_no", "e_no", "generate_no"], name: "resultno_eno"
    t.index ["skill_id"], name: "index_skills_on_skill_id"
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
