class CreateUserFavorites < ActiveRecord::Migration
  def change
    create_table :user_favorites do |t|
      t.integer :user_id, :limit => 8, :null => false, unsigned: true
      t.integer :post_id, :limit => 8, unsigned: true
      t.integer :post_content_id, :limit => 8, unsigned: true

      t.timestamps
    end
    add_index :user_favorites, :user_id
    add_index :user_favorites, :post_id
    add_index :user_favorites, :post_content_id
  end
end
