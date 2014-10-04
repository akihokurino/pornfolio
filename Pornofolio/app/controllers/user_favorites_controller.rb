class UserFavoritesController < ApplicationController
  def index
    #@user = User.find_or_create(cookies[:user_hash])
    @favorites = UserFavorite.where(user_id: @access_user[:id]).order("created_at DESC")
    @categories  = Category.all.sort
  end

  def create
    user = User.find_by(hash_value: params[:user_favorites][:user_hash])
  	hash = {
  		user_id: user.id,
  		post_id: params[:user_favorites][:post_id]
  	}

  	unless UserFavorite.exists?(hash)
  	  UserFavorite.create(hash)
  	end
  end

  def destroy
    #user = User.find_or_create(cookies[:user_hash])
    hash = {
      user_id: @access_user[:id],
      post_id: params[:id]
    }

    if UserFavorite.exists?(hash)
      favorite = UserFavorite.find_by(hash)
      favorite.destroy
    end
  end

  private
  def create_params
  	params.require(:user_favorites).permit(:user_id, :post_id, :post_content_id)
  end
end
