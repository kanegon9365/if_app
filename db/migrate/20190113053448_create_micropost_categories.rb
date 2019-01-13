class CreateMicropostCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :micropost_categories do |t|
      t.integer :micropost_id
      t.integer :category_id

      t.timestamps
    end
    add_index :micropost_categories, :micropost_id
    add_index :micropost_categories, :category_id
    add_index :micropost_categories, [:micropost_id, :category_id], unique: true
  end
end
