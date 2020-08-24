class CreateCurrentAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :current_areas do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :area_id
      t.integer :advance
      t.integer :bellicosity

      t.timestamps
    end
  end
end
