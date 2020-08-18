class AddIndexToSkillData < ActiveRecord::Migration[5.2]
  def change
    add_index :skill_data, :skill_id
    add_index :skill_data, :name
    add_index :skill_data, :embryo_id
    add_index :skill_data, :is_physics
    add_index :skill_data, :lv
    add_index :skill_data, :sp
    add_index :skill_data, :gift_id
    add_index :skill_data, :gp
  end
end
