class AddIndexToEmbryo < ActiveRecord::Migration[5.2]
  def change
    add_index :embryos, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :embryos, :order
    add_index :embryos, :embryo_id
    add_index :embryos, :is_physics
    add_index :embryos, :lv
  end
end
