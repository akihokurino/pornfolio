class CreatePostContents < ActiveRecord::Migration
  def change
    create_table :post_contents do |t|
      t.integer :post_id, :limit => 8, :null => false, unsigned: true
      t.integer :order, :null => false, unsigned: true
      t.integer :post_content_type_id, :null => false, unsigned: true

      t.timestamps
    end
    add_index :post_contents, :post_id
    add_index :post_contents, :post_content_type_id
    add_index :post_contents, [:post_id, :post_content_type_id]
  end
end
