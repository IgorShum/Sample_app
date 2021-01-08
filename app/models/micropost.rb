class Micropost < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 3, maximum: 140 }

  has_rich_text :content

  default_scope -> { order(created_at: :desc) }
end
