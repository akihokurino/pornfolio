class PostContentDetail < ActiveRecord::Base
  has_many :post_content_details_xvideos
  has_many :xvideos, :through => :post_content_details_xvideos
  has_many :asgs_post_content_details
  has_many :asgs, :through => :asgs_post_content_details


  belongs_to :post_content, touch: true
  belongs_to :post_content_detail_type


  class << self
    CONTENT_DETAIL_XVIDEOS = 1.freeze
    CONTENT_DETAIL_ASG     = 2.freeze

    # post_content_detailsの関連テーブルを作成する
    def relation_create(detail_ids)
      import_xvideos detail_ids
      import_asg detail_ids
    end

    private
    # xvideos関連を保存
    def import_xvideos(detail_ids)
      details_videos = where(
          :id                          => detail_ids,
          :post_content_detail_type_id => CONTENT_DETAIL_XVIDEOS
      )
      return if details_videos.blank?
      pcd_texts = details_videos.pluck(:text).map{|text| text.to_i}
      pcd_ids   = details_videos.pluck(:id)
      xvideos   = Xvideos.find_and_create pcd_texts
      post_content_details_xvideos_models = []
      pcd_texts.zip(pcd_ids).each do |pcd_text, pcd_id|
        post_content_details_xvideos_models << PostContentDetailsXvideos.new(
            :post_content_detail_id => pcd_id,
            :xvideos_id             => xvideos[pcd_text]
        )
      end
      PostContentDetailsXvideos.import post_content_details_xvideos_models
    end

    # asg関連を保存
    def import_asg(detail_ids)
      details_videos = where(
          :id                          => detail_ids,
          :post_content_detail_type_id => CONTENT_DETAIL_ASG
      )
      return if details_videos.blank?
      pcd_texts = details_videos.pluck(:text)
      pcd_ids   = details_videos.pluck(:id)
      asg       = Asg.find_and_create pcd_texts
      asgs_post_content_details_models = []
      pcd_texts.zip(pcd_ids).each do |pcd_text, pcd_id|
        asgs_post_content_details_models << PostContentDetailsXvideos.new(
            :post_content_detail_id => pcd_id,
            :asg_id                 => asg[pcd_text]
        )
      end
      AsgsPostContentDetail.import asgs_post_content_details_models
    end
  end
end
