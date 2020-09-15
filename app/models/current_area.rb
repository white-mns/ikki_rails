class CurrentArea < ApplicationRecord
	belongs_to :pc_name, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Name"
	belongs_to :pk_data, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "PkDatum"
	belongs_to :assault, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Assault"
	belongs_to :pk_result, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "PkResult"
	belongs_to :party, :foreign_key => [:e_no, :result_no, :generate_no], :primary_key => [:e_no, :result_no, :generate_no], :class_name => "Party"
	belongs_to :area, :foreign_key => :area_id, :primary_key => :area_id, :class_name => "AreaDatum"
    
    scope :area_total, -> () {
        pluck(:area_id, :advance).inject(Hash.new(0)){|hash, a, b| hash[a] += 1 ; hash}
    }
end
