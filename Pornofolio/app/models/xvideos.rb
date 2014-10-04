class Xvideos < ActiveRecord::Base
  include Redis::Objects
  extend Video::Xvideos
  has_many :post_content_details_xvideos
  has_many :post_content_details, :through => :post_content_details_xvideos

  hash_key :xvideos, :global => true

  class << self
    # 並列処理におけるスレッド数
    PARALLEL_THREAD   = 4.freeze

    # xvideosのハッシュ値を探す、または作成する
    def find_or_create_xvideos_hash(video_id, size = nil)
      # redisからハッシュ値を検索
      xvideos_hash = xvideos[video_id]
      # redisになければデータベースから検索
      xvideos_hash ||= video_hash_value(video_id)

      # XvideosのVideoオブジェクトを作成
      Video.new(video_id, size).tap do |video|
        if xvideos_hash.blank?
          # video情報をスクレイピングして取得して保存する
          video.generate
          save_video(video)
        else
          video.video_hash = xvideos_hash
        end
      end
    end

    # video_idの配列を引数に持ち、検索と作成を行う
    def find_and_create(video_ids)
      video_ids          = video_ids.uniq
      hash_xvideos       = hash_video(video_ids)
      uncollected_videos = video_ids - hash_xvideos.keys
      # PARALLEL_THREAD分だけスレッドを立てて、スクレイピングを並列処理させる
      thread_size =  (uncollected_videos.size > PARALLEL_THREAD) ? PARALLEL_THREAD : uncollected_videos.size
      Parallel.each(uncollected_videos, in_threads: thread_size) do |video_id|
        video = Video.new(video_id)
        video.generate
        new_xvideos = Hash[*save_video(video).pluck(:video_id, :id).flatten]
        hash_xvideos.merge!(new_xvideos)
      end
      hash_xvideos
    end

    private
    # videoオブジェクトを保存する
    def save_video(video)
      self.xvideos[video.video_id] = video.video_hash
      create!(
          :video_id   => video.video_id,
          :hash_value => video.video_hash
      )
    end

    # xvideosのハッシュ値を返す
    def video_hash_value(video_id)
      hash_value = nil
      row = find_by video_id: video_id
      if row.present?
        hash_value = row[:hash_value]
        # redisにも保存
        xvideos[video_id] = hash_value
      end
      hash_value
    end

    # video_idをkeyとするHashを作成
    def hash_video(video_ids)
      Hash[*where(video_id: video_ids.uniq).pluck(:video_id, :id).flatten]
    end
  end
end