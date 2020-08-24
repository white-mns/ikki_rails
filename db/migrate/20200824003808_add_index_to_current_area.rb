class AddIndexToCurrentArea < ActiveRecord::Migration[5.2]
  def change
    add_index :current_areas, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :current_areas, [:result_no, :area_id, :advance], :unique => false, :name => 'resultno_areaid_advance'
    add_index :current_areas, :area_id
    add_index :current_areas, :advance
    add_index :current_areas, :bellicosity
  end
end
