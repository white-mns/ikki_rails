class CreatePrizes < ActiveRecord::Migration[5.2]
  def change
    create_table :prizes do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :prize

      t.timestamps
    end
  end
end
