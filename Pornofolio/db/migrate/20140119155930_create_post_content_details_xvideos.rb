class CreatePostContentDetailsXvideos < ActiveRecord::Migration
  def change
    create_table :post_content_details_xvideos, :id => false do |t|
      t.integer :post_content_detail_id, :limit => 8, :null => false, unsigned: true
      t.integer :xvideos_id, :limit => 8, :null => false, unsigned: true
    end
    add_index :post_content_details_xvideos, :post_content_detail_id
    add_index :post_content_details_xvideos, :xvideos_id
  end
end
