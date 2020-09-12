class CreateAssaults < ActiveRecord::Migration[5.2]
  def change
    create_table :assaults do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :assault_type

      t.timestamps
    end
  end
end
