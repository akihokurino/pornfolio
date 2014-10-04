class IpInfo < ActiveRecord::Base
  has_many :access_logs_ip_infos
  has_many :access_logs, :through => :access_logs_ip_infos

  validates :ip, length: { maximum: 50 }
  validates :latitude, length: { maximum: 15 }
  validates :longitude, length: { maximum: 15 }
  validates :country_name, length: { maximum: 100 }
  validates :country_code, length: { maximum: 2 }
  validates :continent_code, length: { maximum: 2 }

  class << self
    # ip_infosの関連テーブルを作成
    def relation_create
      exists_log_id = AccessLogsIpInfo.all.pluck(:access_log_id)
      access_log    = AccessLog.where.not(id: exists_log_id)
      # IPがなかった場合やローカルからのアクセスの場合は記録しない
      return if ip.blank? || ip =~ /^(127\.)/

      ip_info = IpInfo.find_by ip: ip
      ip_info = create_ip_info(ip) if ip_info.blank?
      AccessLogsIpInfo.create!(
          :access_log_id => log_id,
          :ip_info_id    => ip_info[:id]
      )
    end

    private
    IP_GEO_API = 'http://www.geoplugin.net/json.gp?ip='.freeze
    # ip_infoを外部APIから取得して保存する
    def create_ip_info(ip)
      url         = "#{IP_GEO_API}#{ip}"
      html        = open(url) {|f| f.read }
      geo_api_res = JSON.parse(html)
      create!(
        :ip             => ip,
        :latitude       => geo_api_res['geoplugin_latitude'],
        :longitude      => geo_api_res['geoplugin_longitude'],
        :country_name   => geo_api_res['geoplugin_countryName'],
        :country_code   => geo_api_res['geoplugin_countryCode'],
        :continent_code => geo_api_res['geoplugin_continentCode']
      )
    end

    def request_geo_api(access_log)
      ip = access_log[:ip]
      return if ip.blank? || ip =~ /^127\./
      ip.split(',').each do |item|

      end
    end

  end
end
