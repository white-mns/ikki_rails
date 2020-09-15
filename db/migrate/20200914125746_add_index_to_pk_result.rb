class AddIndexToPkResult < ActiveRecord::Migration[5.2]
  def change
    add_index :pk_results, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :pk_results, :battle_result
  end
end
