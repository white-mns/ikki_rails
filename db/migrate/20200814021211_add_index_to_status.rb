class AddIndexToStatus < ActiveRecord::Migration[5.2]
  def change
    add_index :statuses, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :statuses, :clv
    add_index :statuses, :ikki
    add_index :statuses, :guardian_id
    add_index :statuses, :cp
    add_index :statuses, :ps
    add_index :statuses, :mhp
    add_index :statuses, :msp
    add_index :statuses, :psp
    add_index :statuses, :str
    add_index :statuses, :vit
    add_index :statuses, :tec
    add_index :statuses, :int
    add_index :statuses, :mnd
    add_index :statuses, :agi
  end
end
