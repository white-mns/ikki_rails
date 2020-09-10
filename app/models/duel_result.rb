class DuelResult < ApplicationRecord
	belongs_to :battle_info, :foreign_key => [:before_result_no, :party_no, :before_generate_no], :primary_key => [:result_no, :party_no, :generate_no], :class_name => "NextBattleInfo"
	belongs_to :left_party_info,  -> { where(party_type: 0)}, :foreign_key => [:result_no, :left_party_no, :generate_no], :primary_key => [:result_no, :party_no, :generate_no], :class_name => "PartyInfo"
	belongs_to :right_party_info, -> { where(party_type: 0)}, :foreign_key => [:result_no, :right_party_no, :generate_no], :primary_key => [:result_no, :party_no, :generate_no], :class_name => "PartyInfo"
end
