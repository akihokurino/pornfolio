class DetailVideoWorker
  include Sidekiq::Worker
  sidekiq_options :queue => 'often', :retry => 4

  # post_content_detailに関連するxvideos情報を取得、保存する処理をバックグラウンドへ
  def perform(detail_ids)
    PostContentDetail.relation_create detail_ids
  end
end