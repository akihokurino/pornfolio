class PostContent < ActiveRecord::Base
  belongs_to :post, touch: true

  has_many :post_content_details, :dependent => :destroy
  has_many :user_favorites
  #belongs_to :post_content_types
  belongs_to :post_content_type
end
