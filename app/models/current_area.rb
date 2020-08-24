class CurrentArea < ApplicationRecord
	belongs_to :pc_name, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"
	belongs_to :area, :foreign_key => :area_id, :primary_key => :area_id, :class_name => "AreaDatum"
end
