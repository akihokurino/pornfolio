class CreateBeta < ActiveRecord::Migration
  def change
    create_table :beta do |t|
      t.integer :user_id, :limit => 8, :null => false, unsigned: true
      t.string  :beta_hash, :limit => 40, :null => false

      t.timestamps
    end
    add_index :beta, :user_id, :unique => true
    add_index :beta, :beta_hash, :unique => true
  end
end
