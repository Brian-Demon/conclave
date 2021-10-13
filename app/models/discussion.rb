class Discussion < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments

  validates :category, presence: true
  validates :user, presence: true
end
