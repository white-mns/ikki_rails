class AddIndexToEmbryoName < ActiveRecord::Migration[5.2]
  def change
    add_index :embryo_names, :embryo_id
    add_index :embryo_names, :name
  end
end
