class AddIndexToPrize < ActiveRecord::Migration[5.2]
  def change
    add_index :prizes, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :prizes, :prize
  end
end
