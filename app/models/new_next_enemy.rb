class NewNextEnemy < ApplicationRecord
	belongs_to :enemy, :foreign_key => :enemy_id, :primary_key => :proper_id, :class_name => "ProperName"
	belongs_to :area, :foreign_key => :area_id, :primary_key => :area_id, :class_name => "AreaDatum"
	belongs_to :new_battle, :foreign_key => :enemy_id, :primary_key => :enemy_id, :class_name => "NewBattleEnemy"
	belongs_to :new_defeat,  -> { where(member_num: 0)}, :foreign_key => :enemy_id, :primary_key => :enemy_id, :class_name => "NewDefeatEnemy"
end
