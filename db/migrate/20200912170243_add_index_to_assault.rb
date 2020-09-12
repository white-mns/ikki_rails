class AddIndexToAssault < ActiveRecord::Migration[5.2]
  def change
    add_index :assaults, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :assaults, :assault_type
  end
end
