class AddIndexToBattleResult < ActiveRecord::Migration[5.2]
  def change
    add_index :battle_results, [:result_no, :party_no, :generate_no], :unique => false, :name => 'resultno_partyno'
    add_index :battle_results, [:before_result_no, :party_no, :before_generate_no], :unique => false, :name => 'beforeresultno_partyno'
    add_index :battle_results, :party_no
    add_index :battle_results, :battle_result
  end
end
