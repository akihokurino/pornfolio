class Beta < ActiveRecord::Base
  belongs_to :user


  class << self
    def update_or_create(user_id)
      beta = self.find_by user_id: user_id
      beta.update!(beta_hash: uid) if beta.present?
      beta ||= self.create!(user_id: user_id, beta_hash: uid)
      beta
    end

    def record_nil?(user_id, cookie_value)
      !self.exists?({user_id: user_id, beta_hash: cookie_value})
    end

    def uid
      SecureRandom.uuid.gsub("-", "")
    end
  end
end
