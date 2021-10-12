class User < ApplicationRecord
  has_many :discussions
  has_many :comments

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.login = auth["info"]["name"]
    end
  end

  def self.find_or_create_with_omniauth(auth)
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
  end
end
