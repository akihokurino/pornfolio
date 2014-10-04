class XvideosController < ApplicationController
  resource_description { resource_id @controller.try(:controller_path) || controller_path }
  include Doc::Xvideos

  #rescue_from Xvideos::AccessFail, :with => :error_503

  def thumbnails
    # パラメータをチェック
    @video_id = param_id
    video     = Xvideos.find_or_create_xvideos_hash(@video_id, params[:size])
    # サムネイルをviewにセットする
    @thumbnails = video.thumbnails
  end

  private
  def param_id
    params.require(:id)
  end
end