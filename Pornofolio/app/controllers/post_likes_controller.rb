class PostLikesController < ApplicationController
  def create
  	user = User.find_by(hash_value: params[:post_likes][:user_hash])
  	hash = {
  		user_id: user.id,
  		post_id: params[:post_likes][:post_id]
  	}

  	unless PostLike.exists?(hash)
  	  PostLike.create(hash)
      post = Post.find(hash[:post_id])
      post.update_attributes(:like_count => post[:like_count].to_i.succ)
  	end
  end

  def destroy
  	#user = User.find_or_create(cookies[:user_hash])
    hash = {
      user_id: @access_user[:id],
      post_id: params[:id]
    }

    if PostLike.exists?(hash)
      like = PostLike.find_by(hash)
      like.destroy
      post = Post.find(hash[:post_id])
      post.update_attributes(:like_count => post[:like_count].to_i.pred)
    end
  end
end
