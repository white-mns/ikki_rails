class AddAreaColumnToNewNextEnemy < ActiveRecord::Migration[5.2]
  def change
    add_column :new_next_enemies, :area_id, :integer
    add_column :new_next_enemies, :advance, :integer
    add_index  :new_next_enemies, :area_id
    add_index  :new_next_enemies, :advance
  end
end
