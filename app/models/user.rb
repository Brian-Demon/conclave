class User < ApplicationRecord
  has_many :discussions, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.login = auth["info"]["name"]
      user.image = auth["info"]["image"]
    end
  end

  def self.find_or_create_with_omniauth(auth)
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
  end

  def post_count
    comments.count + discussions.count 
  end
end
