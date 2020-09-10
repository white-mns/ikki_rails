class CreateDuelResults < ActiveRecord::Migration[5.2]
  def change
    create_table :duel_results do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :before_result_no
      t.integer :before_generate_no
      t.integer :left_party_no
      t.integer :right_party_no
      t.integer :battle_result

      t.timestamps
    end
  end
end
