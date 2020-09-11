class AddAreaColumnToNewBattleEnemy < ActiveRecord::Migration[5.2]
  def change
    add_column :new_battle_enemies, :area_id, :integer
    add_column :new_battle_enemies, :advance, :integer
    add_index  :new_battle_enemies, :area_id
    add_index  :new_battle_enemies, :advance
  end
end
