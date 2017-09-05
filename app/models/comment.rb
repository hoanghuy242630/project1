class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  default_scope -> { order(created_at: :asc) }
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
end
