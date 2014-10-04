class Asg < ActiveRecord::Base
  include Redis::Objects
  extend Video::Asg

  has_many :asgs_post_content_details
  has_many :post_content_details, :through => :asgs_post_content_details


  hash_key :asg, :global => true

  class << self
    # videoオブジェクトを保存
    def find_or_create_asg(video_id, size = nil)
      # redisからハッシュ値を検索
      img_path = asg[video_id]
      # redisになければデータベースから検索
      img_path ||= video_img_path(video_id)

      # asgのVideoオブジェクトを作成
      Video.new(video_id, size).tap do |video|
        if img_path.blank?
          video.generate
          save_video(video)
        else
          video.img_path = img_path
        end
      end
    end

    # video_idの配列を引数に持ち、検索と作成を行う
    def find_and_create(video_ids)
      video_ids = video_ids.uniq
      hash_asg  = hash_video(video_ids)
      uncollected_videos = video_ids - hash_asg.keys
      # PARALLEL_THREAD分だけスレッドを立てて、スクレイピングを並列処理させる
      Parallel.each(uncollected_videos, in_threads: PARALLEL_THREAD) do |video_id|
        video = Video.new(video_id)
        video.generate
        new_asg = Hash[*save_video(video).pluck(:video_id, :id).flatten]
        hash_asg.merge!(new_asg)
      end
      hash_asg
    end

    private
    # asgテーブルに保存
    def save_video(video)
      create!(
          :video_id => video.video_id,
          :title    => video.title,
          :img_path => video.img_path
      )
    end

    # asgのimg_pathを返す
    def video_img_path(video_id)
      img_path = nil
      row = find_by video_id: video_id
      if row.present?
        img_path = row[:img_path]
        # redisにも保存
        asg[video_id] = img_path
      end
      img_path
    end

    # video_idをkeyとするHashを作成
    def hash_video(video_ids)
      Hash[*where(video_id: video_ids.uniq).pluck(:video_id, :id).flatten]
    end
  end
end
