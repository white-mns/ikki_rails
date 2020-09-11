class NewDefeatEnemy < ApplicationRecord
	belongs_to :battle_info, :foreign_key => [:before_result_no, :party_no, :before_generate_no], :primary_key => [:result_no, :party_no, :generate_no], :class_name => "NextBattleInfo"
	belongs_to :party_info,  -> { where(party_type: 0)}, :foreign_key => [:result_no, :party_no, :generate_no], :primary_key => [:result_no, :party_no, :generate_no], :class_name => "PartyInfo"
	belongs_to :enemy, :foreign_key => :enemy_id, :primary_key => :proper_id, :class_name => "ProperName"
end
