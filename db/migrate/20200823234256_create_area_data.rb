class CreateAreaData < ActiveRecord::Migration[5.2]
  def change
    create_table :area_data do |t|
      t.integer :area_id
      t.string :name
      t.integer :level

      t.timestamps
    end
  end
end
