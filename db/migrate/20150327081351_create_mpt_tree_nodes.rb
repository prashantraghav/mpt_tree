class CreateMptTreeNodes < ActiveRecord::Migration
  def change
    create_table :mpt_tree_nodes do |t|
      t.integer :tree_id
      t.string :tree_type
      t.integer :lft
      t.integer :rgt

      t.timestamps
    end
  end
end
