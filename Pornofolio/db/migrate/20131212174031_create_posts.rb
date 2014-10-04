class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, :limit => 255, :null => false
      t.integer :user_id, :limit => 8, :null => false, unsigned: true
      t.text :thumbnail, :null => true, :default => nil
      t.string :description, :limit => 255
      t.integer :post_type_id, :null => false, unsigned: true
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :posts, :user_id
    add_index :posts, :post_type_id
    add_index :posts, :created_at
    add_index :posts, :updated_at
  end
end
