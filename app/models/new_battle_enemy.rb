class NewBattleEnemy < ApplicationRecord
	belongs_to :enemy, :foreign_key => :enemy_id, :primary_key => :proper_id, :class_name => "ProperName"
	belongs_to :area, :foreign_key => :area_id, :primary_key => :area_id, :class_name => "AreaDatum"
end
