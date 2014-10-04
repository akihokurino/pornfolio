class CreatePostLikes < ActiveRecord::Migration
  def change
    create_table :post_likes do |t|
      t.integer :post_id, :limit => 8, :null => false, unsigned: true
      t.integer :user_id, :limit => 8, :null => false, unsigned: true

      t.timestamps
    end
    add_index :post_likes, :post_id
    add_index :post_likes, :user_id
  end
end
