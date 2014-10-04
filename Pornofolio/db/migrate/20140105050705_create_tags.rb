class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, :limit => 150, :null => false

      t.timestamps
    end
    add_index :tags, :name, :unique => true
  end
end
