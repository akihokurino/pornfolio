class CreatePostContentDetailTypes < ActiveRecord::Migration
  def change
    create_table :post_content_detail_types do |t|
      t.string :name, :limit => 150 , :null => false

    end
    add_index :post_content_detail_types, :name, :unique => true
  end
end
