class NextDuelInfo < ApplicationRecord
	belongs_to :current_area, :foreign_key => [:result_no, :left_party_no, :generate_no], :primary_key => [:result_no, :e_no,     :generate_no], :class_name => "CurrentArea"
	belongs_to :left_party_info,  -> { where(party_type: 11)}, :foreign_key => [:result_no, :left_party_no, :generate_no],  :primary_key => [:result_no, :party_no, :generate_no], :class_name => "PartyInfo"
	belongs_to :right_party_info, -> { where(party_type: 11)}, :foreign_key => [:result_no, :right_party_no, :generate_no], :primary_key => [:result_no, :party_no, :generate_no], :class_name => "PartyInfo"
	belongs_to :left_party_assault,  :foreign_key => [:result_no, :left_party_no, :generate_no],  :primary_key => [:result_no, :e_no, :generate_no], :class_name => "Assault"
	belongs_to :right_party_assault, :foreign_key => [:result_no, :right_party_no, :generate_no], :primary_key => [:result_no, :e_no, :generate_no], :class_name => "Assault"
end
