class IpInfoWorker
  require 'open-uri'
  include Sidekiq::Worker
  sidekiq_options :queue => 'seldom', :retry => 5

  def perform(log_id, log_ip)
    IpInfo.relation_create log_id, log_ip
  end
end