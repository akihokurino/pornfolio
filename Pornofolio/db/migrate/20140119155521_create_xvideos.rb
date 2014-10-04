class CreateXvideos < ActiveRecord::Migration
  def change
    create_table :xvideos do |t|
      t.integer :video_id, :null => false, :unsigned => true
      t.string :hash_value, :limit => 40, :null => false

      t.timestamps
    end
    add_index :xvideos, :video_id, :unique => true
    add_index :xvideos, :hash_value, :unique => true
  end
end