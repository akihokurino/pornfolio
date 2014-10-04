class CreatePostContentDetails < ActiveRecord::Migration
  def change
    create_table :post_content_details do |t|
      t.integer :post_content_id, :limit => 8, :null => false, unsigned: true
      t.text :text, :null => false
      t.boolean :is_broken, :null => false, :default => false
      t.boolean :is_request, :null => false, :default => false
      t.integer :post_content_detail_type_id, :null => false

      t.timestamps
    end
    add_index :post_content_details, :post_content_id
    add_index :post_content_details, :post_content_detail_type_id
  end
end
