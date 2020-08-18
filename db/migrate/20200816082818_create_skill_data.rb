class CreateSkillData < ActiveRecord::Migration[5.2]
  def change
    create_table :skill_data do |t|
      t.integer :skill_id
      t.string :name
      t.integer :embryo_id
      t.integer :is_physics
      t.integer :lv
      t.integer :sp
      t.integer :gift_id
      t.integer :gp

      t.timestamps
    end
  end
end
