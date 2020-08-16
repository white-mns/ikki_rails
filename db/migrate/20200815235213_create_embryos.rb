class CreateEmbryos < ActiveRecord::Migration[5.2]
  def change
    create_table :embryos do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :order
      t.integer :embryo_id
      t.integer :is_physics
      t.integer :lv

      t.timestamps
    end
  end
end
