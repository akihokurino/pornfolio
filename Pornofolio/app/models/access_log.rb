class AccessLog < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  has_many :access_logs_ip_infos
  has_many :ip_infos, :through => :access_logs_ip_infos


end
