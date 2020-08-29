class BattleResult < ApplicationRecord
	belongs_to :battle_info, :foreign_key => [:before_result_no, :party_no, :before_generate_no], :primary_key => [:result_no, :party_no, :generate_no], :class_name => "NextBattleInfo"
	has_many :enemy_members, :foreign_key => [:result_no, :party_no, :generate_no], :primary_key => [:before_result_no, :party_no, :before_generate_no], :class_name => 'NextBattleEnemy'
	belongs_to :party_info,  -> { where(party_type: 0)}, :foreign_key => [:result_no, :party_no, :generate_no], :primary_key => [:result_no, :party_no, :generate_no], :class_name => "PartyInfo"
end
