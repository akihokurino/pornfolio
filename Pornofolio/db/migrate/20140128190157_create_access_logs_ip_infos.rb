class CreateAccessLogsIpInfos < ActiveRecord::Migration
  def change
    create_table :access_logs_ip_infos, :id => false do |t|
      t.integer :access_log_id, :limit => 8, :null => false, unsigned: true
      t.integer :ip_info_id, :null => false, unsigned: true
    end
    add_index :access_logs_ip_infos, :access_log_id
    add_index :access_logs_ip_infos, :ip_info_id
  end
end
