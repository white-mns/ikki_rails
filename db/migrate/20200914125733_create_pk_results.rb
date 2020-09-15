class CreatePkResults < ActiveRecord::Migration[5.2]
  def change
    create_table :pk_results do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :battle_result

      t.timestamps
    end
  end
end
