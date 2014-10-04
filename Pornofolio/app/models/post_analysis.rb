class PostAnalysis < ActiveRecord::Base
  belongs_to :post
  belongs_to :post_analysis_types

  VIEW_ID = 1.freeze

  class << self
    # デフォルトでTOP5のランキングを計算する
    def tally_ranking(top = 5)
      ranking_hash = {}
      {day: 1.day, week: 1.week, month: 1.month}.each do |key, value|
        sorted_rank = self.tally(value, top)
        rank        = sorted_rank[:rank]
        if rank.size < top
          old_rank = self.tally(5.day, top - rank.size, sorted_rank[:keys])
          rank    += old_rank[:rank] if old_rank[:rank].present?
        end
        ranking_hash[key] = rank.map{|item| item[0]}
      end
      Post.ranking =  ranking_hash.to_json
    end

    def tally(subject, top, ignore_posts = nil)
      range = term_range(subject)
      rank  = self.where(post_analysis_type_id: VIEW_ID, measured_at: range).where.not(post_id: ignore_posts).group(:post_id).order('count_post_id desc').limit(top).count(:post_id)
      {keys: rank.keys, rank: rank.sort_by{|k, v| -v}}
    end


    def find_view
      self.find_by(post_analysis_type_id: VIEW_ID)
    end

    def create_view(post)
      transaction do
        self.create!(
            :post_id               => post[:id],
            :post_analysis_type_id => VIEW_ID,
            :measured_at           => Time.now
        )
        post[:view_count] += 1
        post.save!
      end
    end

    private
    # subjectから現在の時刻までのrangeを取得
    def term_range(subject = 1.day)
      to   = Time.now
      from = to - subject
      from...to
    end
  end
end
