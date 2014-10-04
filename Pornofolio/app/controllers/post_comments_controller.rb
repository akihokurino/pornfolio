class PostCommentsController < ApplicationController
  def create
  	user = User.find_by(hash_value: params[:post_comments][:user_hash])
  	@comment = PostComment.new(:user_id => user.id, :post_id => params[:post_comments][:post_id], :text => params[:post_comments][:text])
  	@comment.save
  end

  private
  def create_params
    params.require(:post_comments).permit(:post_id, :user_id, :text)
  end
end
