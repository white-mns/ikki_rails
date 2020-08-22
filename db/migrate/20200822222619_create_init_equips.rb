class CreateInitEquips < ActiveRecord::Migration[5.2]
  def change
    create_table :init_equips do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :i_no

      t.timestamps
    end
  end
end
