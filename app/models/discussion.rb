class Discussion < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments

  validates :category, presence: true
  validates :user, presence: true
  validates :body, presence: true

  before_save :assign_formatted_body, if: -> { body_changed? }

  def assign_formatted_body
    assign_attributes(formatted_body: MarkdownRenderer.render(body))
  end
end
