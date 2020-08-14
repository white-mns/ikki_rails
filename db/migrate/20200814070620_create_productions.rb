class CreateProductions < ActiveRecord::Migration[5.2]
  def change
    create_table :productions do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :cook
      t.integer :make
      t.integer :composition
      t.integer :addition

      t.timestamps
    end
  end
end
