class CreateNewEmbryos < ActiveRecord::Migration[5.2]
  def change
    create_table :new_embryos do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :embryo_id

      t.timestamps
    end
  end
end
