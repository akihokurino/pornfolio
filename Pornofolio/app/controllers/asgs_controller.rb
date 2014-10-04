class AsgsController < ApplicationController
  resource_description { resource_id @controller.try(:controller_path) || controller_path }
  include Doc::Asgs

  #rescue_from AsgAccessFail, :with => :error_503

  def thumbnails
    # パラメータをチェック
    @video_id = param_id
    video = Asg.find_or_create_asg(@video_id, params[:size])
    # サムネイルをviewにセットする
    @thumbnails = video.thumbnails
  end

  private
  def param_id
    params.require(:id)
  end
end
