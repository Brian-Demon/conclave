class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :discussion

  validates :discussion, presence: true
  validates :user, presence: true
end
