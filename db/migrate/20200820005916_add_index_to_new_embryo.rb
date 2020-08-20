class AddIndexToNewEmbryo < ActiveRecord::Migration[5.2]
  def change
    add_index :new_embryos, [:result_no, :generate_no], :unique => false, :name => 'resultno_generateno'
    add_index :new_embryos, :embryo_id
  end
end
