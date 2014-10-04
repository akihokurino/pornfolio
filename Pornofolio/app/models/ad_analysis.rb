class AdAnalysis < ActiveRecord::Base
  belongs_to :ad
  belongs_to :user
  belongs_to :post


  class << self
    def create_analysis(params, user)
      return false unless Ad.exists?(id: params[:ad_id])
      self.create!(
          :ad_id    => params[:ad_id],
          :user_id  => user[:user_id],
          :post_id  => params[:post_id],
          :view_url => params[:view_url]
      )
      true
    end
  end
end
