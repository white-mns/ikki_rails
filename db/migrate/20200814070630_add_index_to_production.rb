class AddIndexToProduction < ActiveRecord::Migration[5.2]
  def change
    add_index :productions, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :productions, :cook
    add_index :productions, :make
    add_index :productions, :composition
    add_index :productions, :addition
  end
end
