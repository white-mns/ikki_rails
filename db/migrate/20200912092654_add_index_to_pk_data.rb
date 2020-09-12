class AddIndexToPkData < ActiveRecord::Migration[5.2]
  def change
    add_index :pk_data, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :pk_data, :pk_num
    add_index :pk_data, :pk_win_num
    add_index :pk_data, :latest_pk_result_no
    add_index :pk_data, :pkk_num
    add_index :pk_data, :pkk_win_num
    add_index :pk_data, :latest_pkk_result_no
  end
end
