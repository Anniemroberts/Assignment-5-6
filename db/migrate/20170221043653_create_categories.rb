class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.text :name

      t.timestamps
    end
    add_column :posts, :category_id, :integer
  end
end
