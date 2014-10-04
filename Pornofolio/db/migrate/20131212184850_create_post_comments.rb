class CreatePostComments < ActiveRecord::Migration
  def change
    create_table :post_comments do |t|
      t.integer :post_id, :limit => 8, :null => false, unsigned: true
      t.integer :user_id, :limit => 8, :null => false, unsigned: true
      t.text :text, :null => false

      t.timestamps
    end
    add_index :post_comments, :post_id
    add_index :post_comments, :user_id
  end
end
