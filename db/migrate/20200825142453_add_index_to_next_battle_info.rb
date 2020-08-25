class AddIndexToNextBattleInfo < ActiveRecord::Migration[5.2]
  def change
    add_index :next_battle_infos, [:result_no, :party_no, :generate_no], :unique => false, :name => 'resultno_partyno'
    add_index :next_battle_infos, :is_boss
    add_index :next_battle_infos, :enemy_party_name_id
    add_index :next_battle_infos, :member_num
    add_index :next_battle_infos, :enemy_names
  end
end
