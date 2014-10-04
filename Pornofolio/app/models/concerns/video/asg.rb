module Video::Asg
  extend ActiveSupport::Concern
  require 'open-uri'

  HOST        = 'http://asg.to'.freeze
  VIDEO_PAGE  = '/contentsPage.html?mcd='.freeze
  SEARCH_PATH = '/search?q='.freeze
  class AccessFail < StandardError; end
  class DeletePage < StandardError; end

  class Video
    attr_accessor :video_id, :size, :img_path

    def initialize(video_id, size = nil)
      @video_id = video_id
      @size     = size
    end

    def title
      @title.strip
    end

    def thumbnails
      generate_thumbnail_urls
    end

    # asgオブジェクトを作成する関数
    def generate
      video_url = "#{HOST}#{VIDEO_PAGE}#{self.video_id}"
      doc = nokogiri_object(video_url)
      raise DeletePage.new("Asg: ID #{self.video_id} video may have benn deleted") if doc.css('#notfound').present?
      @title = doc.css('#title').text
      doc.css('.thumbnail img').attr('src').text =~ /https?:\/\/((.*\.flv\/)|(.*\.mp4\/))/
      $1 =~ /(.+)\/$/
      @img_path = $1
    end

    private
    THUMBNAIL_URL_TEMPLATE = "http://%{path}/%{size}/%{num}".freeze
    USER_AGENT = 'Mozilla/5.0 (iPhone; CPU iPhone OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11A465 Safari/9537.53'.freeze
    # URLからnokogiriのobjectを生成する
    def nokogiri_object(url)
      charset = nil
      html = open(url, "User-Agent" => USER_AGENT) do |f|
        charset = f.charset
        f.read
      end
      begin
        doc = Nokogiri::HTML.parse(html, nil, charset)
      rescue
        raise AccessFail.new('Access denied to xvideos site')
      end
      doc
    end

    # thumbnailのURLを作成する
    def generate_thumbnail_urls
      thumbnail_urls  = []

      (0..25).each do |num|
        thumbnail_urls <<  THUMBNAIL_URL_TEMPLATE % {path: self.img_path, size: thumbnail_size, num: num}
      end
      thumbnail_urls
    end

    # thumbnailのサイズの文字列を返す関数
    def thumbnail_size
      size_str = '140x105'
      case self.size
        when 'xs'
          size_str = '80x60'
        when 's'
          size_str = '100x75'
        when 'l'
          size_str = '150x111'
        when 'xl'
          size_str = '200x148'
        when 'h'
          size_str = '450x338'
      end
      size_str
    end
  end
end