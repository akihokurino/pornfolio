class CreatePostTypes < ActiveRecord::Migration
  def change
    create_table :post_types do |t|
      t.string :name, :limit => 100 , :null => false

    end
    add_index :post_types, :name, :unique => true
  end
end
