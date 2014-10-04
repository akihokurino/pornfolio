class User < ActiveRecord::Base
  has_many :posts
  has_many :access_logs
  has_many :user_favorites
  has_many :user_contacts
  has_many :betas
  has_many :post_likes

  validates :hash_value, length: { is: 32 }, :presence => true
  validates :name, length: { maximum: 50 }



  class << self
    # ユーザー固有のハッシュ値を持っていない場合は作る
    def find_or_create(hash_value=nil)
      hash_value =  SecureRandom.uuid.gsub("-", "") if hash_value.blank?
      find_or_create_by hash_value: hash_value
    end

  end
end
