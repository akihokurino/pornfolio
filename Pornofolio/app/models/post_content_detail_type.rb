class PostContentDetailType < ActiveRecord::Base
  include TransformType
  has_many :post_content_details

  validates :name, length: { maximum: 150 }, :presence => true
end
