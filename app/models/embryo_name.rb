class EmbryoName < ApplicationRecord
	has_many :skill, :foreign_key => [:e_no, :result_no, :generate_no, :embryo_id], :primary_key => [:e_no, :result_no, :generate_no, :order, :embryo_id], :class_name => "SkillDatum"
end
