class AdsController < ApplicationController
  resource_description { resource_id @controller.try(:controller_path) || controller_path }
  include Doc::Ads

  DEFAULT_SIDE_COUNT   = 3.freeze
  DEFAULT_FOOTER_COUNT = 3.freeze

  def index
    side_count   = (params[:side].present? && params[:side] < DEFAULT_SIDE_COUNT) ? params[:side] : DEFAULT_SIDE_COUNT
    footer_count = (params[:footer].present? && params[:footer] < DEFAULT_FOOTER_COUNT) ? params[:footer] : DEFAULT_FOOTER_COUNT
    @side_ad     = Ad.find_ad(side_count, 'square', {company: 'tenga', num: 1, unique: true})
    @footer_ad   = Ad.find_ad(footer_count, 'rectangle' , {company: 'tenga', num: 1, unique: true})
  end

  def create
    unless AdAnalysis.create_analysis(create_params, @user_log)
      raise ActionController::ParameterMissing.new('Ad id is not exist from params.')
    end
  end

  private
  def create_params
    params.require(:ad).permit(:ad_id, :post_id, :view_url)
  end
end
