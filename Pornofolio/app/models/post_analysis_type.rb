class PostAnalysisType < ActiveRecord::Base
  has_many :post_analysises

  validates :name, length: { maximum: 100 }, :presence => true
end
