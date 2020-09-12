class CreatePkData < ActiveRecord::Migration[5.2]
  def change
    create_table :pk_data do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :pk_num
      t.integer :pk_win_num
      t.integer :latest_pk_result_no
      t.integer :pkk_num
      t.integer :pkk_win_num
      t.integer :latest_pkk_result_no

      t.timestamps
    end
  end
end
