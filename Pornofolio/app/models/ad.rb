class Ad < ActiveRecord::Base
  has_many :ad_analyses

  DEFAULT_UPPER = 3.freeze

  class << self
    def find_ad(count = 3, ad_type = 'rectangle', *options)
      ad_ids           = []
      ignore_companies = []
      options.each do |option|
        next if option[:company].blank? || option[:num].blank?
        ids     = self.where(company: option[:company], ad_type: ad_type).pluck(:id).shuffle[0...option[:num]]
        ad_ids += ids
        ignore_companies << option[:company] if option[:unique].present? && option[:unique]
      end
      ad_count = ad_ids.size
      if ad_count < count
        ad_ids += self.where.not(id: ad_ids, company: ignore_companies).where(ad_type: ad_type).pluck(:id).sample(count - ad_count)
      elsif ad_count > count
        ad_ids = ad_ids.sample(count)
      end
      self.request_ad(self.where(id: ad_ids, ad_type: ad_type))
    end

    def request_ad(ads)
      ad       = []
      ad_mutex = Mutex.new
      thread_num = ads.size < 3 ? ads.size : 3
      Parallel.each(ads, in_threads: thread_num) {|row|
        if row[:company] == 'tenga'
          res = self.tenga row[:ad_object]
        elsif row[:company] == 'yicha'
          res = Net::HTTP.get(URI.parse(row[:ad_object]))
        #elsif row[:company] == 'imobile'
        else
          res = row[:ad_object]
        end
        row[:ad_object] = res.strip
        ad_mutex.synchronize{ ad << row }
      }
      ad
    end


    def tenga(id = nil)
      domain     = (Rails.env.production?) ? '' : 'http://127.0.0.1:9000'
      id       ||=  1
      index      = id.to_i - 1
      tenga_link = 'http://www.amazon.co.jp/gp/feature.html/ref=amb_link_62529149_5?ie=UTF8&docId=3077107266&pf_rd_i=TENGA/2014oomovie-22'
      tenga_img  = [
          domain + '/images/ad/tenga01-300.png',
          domain + '/images/ad/tenga02-300.png',
          domain + '/images/ad/tenga03-300.png',
          domain + '/images/ad/tenga01-250.png',
          domain + '/images/ad/tenga02-250.png',
          domain + '/images/ad/tenga03-250.png'
      ]
      html    = <<-EOS
      <a href="#{tenga_link}" target="_blank"><img src="#{tenga_img[index]}" alt="tenga_ad"></a>
      EOS
      html
    end
  end
end
