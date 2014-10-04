class CreatePostContentTypes < ActiveRecord::Migration
  def change
    create_table :post_content_types do |t|
      t.string :name, :limit => 150 , :null => false

    end
    add_index :post_content_types, :name, :unique => true
  end
end
