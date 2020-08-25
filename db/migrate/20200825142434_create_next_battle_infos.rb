class CreateNextBattleInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :next_battle_infos do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :party_no
      t.integer :is_boss
      t.integer :enemy_party_name_id
      t.integer :member_num
      t.string :enemy_names

      t.timestamps
    end
  end
end
