class Embryo < ApplicationRecord
	belongs_to :pc_name, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"
	belongs_to :embryo, :foreign_key => :embryo_id, :primary_key => :embryo_id, :class_name => "EmbryoName"
end
