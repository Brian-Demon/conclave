class User < ApplicationRecord
  ROLES = %w{admin moderator user banned}

  has_many :discussions, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :auth_role, inclusion: { in: ROLES }

  before_validation(on: :create) do 
    self.auth_role ||= self.class.default_auth_role
  end

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

  def self.default_auth_role
    "user"
  end
end
