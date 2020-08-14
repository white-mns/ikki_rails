class CreateStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :statuses do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :clv
      t.integer :ikki
      t.integer :guardian_id
      t.integer :cp
      t.integer :ps
      t.integer :mhp
      t.integer :msp
      t.integer :psp
      t.integer :str
      t.integer :vit
      t.integer :tec
      t.integer :int
      t.integer :mnd
      t.integer :agi

      t.timestamps
    end
  end
end
