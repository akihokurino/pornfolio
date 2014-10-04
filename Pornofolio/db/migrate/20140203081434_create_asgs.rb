class CreateAsgs < ActiveRecord::Migration
  def change
    create_table :asgs do |t|
      t.string :video_id, :limit => 30, :null => false
      t.string :title
      t.string :img_path, :limit => 60, :null => false

      t.timestamps
    end
    add_index :asgs, :video_id, :unique => true
    add_index :asgs, :img_path, :unique => true
  end
end
