class SkillDatum < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

	belongs_to :embryo, :foreign_key => :embryo_id, :primary_key => :embryo_id, :class_name => "EmbryoName"
	belongs_to :gift, :foreign_key => :gift_id, :primary_key => :proper_id, :class_name => "ProperName"

    scope :groups, ->(params) {
        skill_group(params)
    }

    scope :skill_group, ->(params) {
        if params["show_skill"] == "0" then group(:embryo_id) end
    }

    scope :wheres, ->(params) {
        skill_id_where(params)
    }

    scope :skill_id_where, ->(params) {
        where(skill_id: 1..Float::INFINITY)
    }
end
