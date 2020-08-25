class CreateNextBattleEnemies < ActiveRecord::Migration[5.2]
  def change
    create_table :next_battle_enemies do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :party_no
      t.integer :is_boss
      t.integer :enemy_id

      t.timestamps
    end
  end
end
