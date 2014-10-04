class CreatePostsTags < ActiveRecord::Migration
  def change
    create_table :posts_tags, :id => false do |t|
      t.integer :post_id, :limit => 8, :null => false, unsigned: true
      t.integer :tag_id, :null => false, unsigned: true
    end
    add_index :posts_tags, :post_id
    add_index :posts_tags, :tag_id
  end
end
