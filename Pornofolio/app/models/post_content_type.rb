class PostContentType < ActiveRecord::Base
  include TransformType
  has_many :post_contents

  validates :name, length: { maximum: 150 }, :presence => true
end
