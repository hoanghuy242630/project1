class Post < ApplicationRecord
  belongs_to :user
  default_scope -> {order created_at: :desc}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, :title, presence: true, length: {maximum: Settings.post.maximum_length}
  validate  :picture_size

  scope :feed, -> (user_id){where user_id: user_id}

  private
    def picture_size
      if picture.size > Settings.post.byte.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
