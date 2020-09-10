class AddIndexToDuelResult < ActiveRecord::Migration[5.2]
  def change
    add_index :duel_results, [:result_no, :left_party_no, :generate_no], :unique => false, :name => 'resultno_leftpartyno'
    add_index :duel_results, [:result_no, :right_party_no, :generate_no], :unique => false, :name => 'resultno_rightpartyno'
    add_index :duel_results, [:before_result_no, :left_party_no, :before_generate_no], :unique => false, :name => 'beforeresultno_leftpartyno'
    add_index :duel_results, [:before_result_no, :right_party_no, :before_generate_no], :unique => false, :name => 'beforeresultno_rightpartyno'
    add_index :duel_results, :left_party_no
    add_index :duel_results, :right_party_no
    add_index :duel_results, :battle_result
  end
end
