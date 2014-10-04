class UserFavorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  belongs_to :post_content
end
