class CreateEmbryoNames < ActiveRecord::Migration[5.2]
  def change
    create_table :embryo_names do |t|
      t.integer :embryo_id
      t.string :name

      t.timestamps
    end
  end
end
