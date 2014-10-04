class CreateAccessLogs < ActiveRecord::Migration
  def change
    create_table :access_logs do |t|
      t.integer :user_id, :limit => 8, :null => false, unsigned: true
      t.text :user_agent, :null => true, :default => nil
      t.text :referer, :null => true, :default => nil
      t.integer :post_id, :limit => 8, unsigned: true
      t.text :access_url, :null => false
      t.string :request_method, :limit => 10, :null => false
      t.string :ip, :limit => 50, :null => false

      t.timestamps
    end
    add_index :access_logs, :user_id
    add_index :access_logs, :post_id
    add_index :access_logs, :created_at
    add_index :access_logs, :ip
  end
end
