class AccessLogsIpInfo < ActiveRecord::Base
  belongs_to :access_log
  belongs_to :ip_info

  validates :access_log_id, :presence => true
  validates :ip_info_id, :presence => true
end
