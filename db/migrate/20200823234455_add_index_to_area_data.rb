class AddIndexToAreaData < ActiveRecord::Migration[5.2]
  def change
    add_index :area_data, :area_id
    add_index :area_data, :name
    add_index :area_data, :level
  end
end
