class CreateIpInfos < ActiveRecord::Migration
  def change
    create_table :ip_infos do |t|
      t.string :ip, :limit => 50, :null => false
      t.string :latitude, :limit => 15, :null => true
      t.string :longitude, :limit => 15, :null => true
      t.string :country_name, :limit => 100, :null => true
      t.string :country_code, :limit => 2, :null => true
      t.string :continent_code, :limit => 2, :null => true

      t.timestamps
    end
    add_index :ip_infos, :ip, :unique => true
    add_index :ip_infos, [:ip, :latitude, :longitude]
    add_index :ip_infos, [:ip, :country_name]
  end
end
