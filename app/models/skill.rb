class Skill < ApplicationRecord
	belongs_to :pc_name, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"
	belongs_to :embryo, :foreign_key => [:e_no, :result_no, :generate_no, :order], :primary_key => [:e_no, :result_no, :generate_no, :order], :class_name => "Embryo"
	belongs_to :skill, :foreign_key => :skill_id, :primary_key => :skill_id, :class_name => "SkillDatum"

    scope :groups, ->(params) {
        skill_group(params)
    }

    scope :skill_group, ->(params) {
        if params["show_skill"] == "0" then group(:result_no, :e_no, "embryos.embryo_id") end
    }

    scope :wheres, ->(params) {
        skill_id_where(params)
    }

    scope :skill_id_where, ->(params) {
        where(skill_id: 1..Float::INFINITY)
    }
end
