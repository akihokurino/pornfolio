module Video::Xvideos
  extend ActiveSupport::Concern
  require 'open-uri'

  HOST             = 'http://www.xvideos.com'.freeze
  VIDEO_PATH_HEAD  = '/video'.freeze
  class AccessFail < StandardError; end
  class DeletePage < StandardError; end

  class Video
    attr_accessor :video_id, :size, :video_hash

    def initialize(video_id, size = nil)
      @video_id = video_id
      @size = size
    end

    def related
      @related
    end

    def flv_url
      @flv_url
    end

    def thumbnails
      generate_thumbnail_urls
    end

    # xvideosオブジェクトを作成する関数
    def generate
      video_url = "#{HOST}#{VIDEO_PATH_HEAD}#{self.video_id}"
      begin
        doc = nokogiri_object(video_url)
      rescue
        raise AccessFail.new('Access denied to xvideos site')
      end
      flash_vars = doc.xpath('//embed/@flashvars')
      raise DeletePage.new("Xvideos: ID #{self.video_id} video may have benn deleted") if flash_vars.blank?
      flash_hash = Hash[flash_vars.to_s.split('&').map{|params| params.split('=').map {|item| URI.decode(item)}}]

      @flv_url     = flash_hash['flv_url']
      @related     = generate_related(flash_hash['related']) if flash_hash['related'].present?
      @link_url    = flash_hash['linkurl']
      @categories  = flash_hash['categories'].split(',') if flash_hash['categories'].present?
      @video_hash  = extract_video_hash(flash_hash['url_bigthumb'])
    end


    private
    # relatedのkeyを用意しておく
    RELATED_KEYS = ['title', 'url', 'thumbnail', 'time'].freeze
    THUMBNAIL_URL_TEMPLATE = "http://img100.xvideos.com/videos/%{size}/%{hash0}/%{hash1}/%{hash2}/%{hash}/%{hash}.%{num}.jpg".freeze

    # relatedの値を分解してHashの配列にする
    def generate_related(related_str)
      related_str.split(';').map{|detail|
        Hash[RELATED_KEYS.zip(detail.split('|').map{|item|
          item.gsub('+',' ')
        })]
      }
    end

    # URLからnokogiriのobjectを生成する
    def nokogiri_object(url)
      charset = nil
      html = open(url) do |f|
        charset = f.charset
        f.read
      end
      Nokogiri::HTML.parse(html, nil, charset)
    end

    # thumbnailのURLから動画のハッシュ値を抽出
    def extract_video_hash(url)
      url =~ %r{.*/(.+)\.[0-9]+\.jpg}
      $1
    end

    # thumbnailのURLを作成する
    def generate_thumbnail_urls
      thumbnail_urls  = []
      parts = [0, 2, 4].map{|i| self.video_hash.slice(i, 2)}
      (1..30).each do |num|
        thumbnail_urls <<  THUMBNAIL_URL_TEMPLATE % {size: thumbnail_size, hash0: parts[0], hash1: parts[1], hash2: parts[2], hash: self.video_hash, num: num}
      end
      thumbnail_urls
    end

    # thumbnailのサイズの文字列を返す関数
    def thumbnail_size
      size_str = 'thumbs'
      case self.size
        when 'l'
          size_str << self.size
        when 'll'
          size_str << self.size
        when 'lll'
          size_str << self.size
      end
      size_str
    end

  end
end