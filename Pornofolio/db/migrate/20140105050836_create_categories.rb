class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, :limit => 100, :null => false

    end
    add_index :categories, :name, :unique => true
  end
end
