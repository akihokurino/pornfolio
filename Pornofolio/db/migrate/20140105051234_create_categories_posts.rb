class CreateCategoriesPosts < ActiveRecord::Migration
  def change
    create_table :categories_posts, :id => false do |t|
      t.integer :post_id, :limit => 8, :null => false, unsigned: true
      t.integer :category_id, :null => false, unsigned: true
    end
    add_index :categories_posts, :post_id
    add_index :categories_posts, :category_id
  end
end
