class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :hash_value, :limit => 40, :null => false
      t.string :name, :limit => 50

      t.timestamps
    end
    add_index :users, :hash_value, :unique => true
  end
end
