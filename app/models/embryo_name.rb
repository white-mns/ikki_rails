class EmbryoName < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

	has_many :skill, :foreign_key => [:e_no, :result_no, :generate_no, :embryo_id], :primary_key => [:e_no, :result_no, :generate_no, :order, :embryo_id], :class_name => "SkillDatum"
end
