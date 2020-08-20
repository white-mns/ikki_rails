class AddIndexToNewSkill < ActiveRecord::Migration[5.2]
  def change
    add_index :new_skills, [:result_no, :generate_no], :unique => false, :name => 'resultno_generateno'
    add_index :new_skills, :skill_id
  end
end
