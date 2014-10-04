class PostType < ActiveRecord::Base
  include TransformType
  has_many :posts

  validates :name, length: { maximum: 100 }, :presence => true
end
