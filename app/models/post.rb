class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :comments, lambda { order(created_at: :desc) }, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

    delegate :name, to: :category, prefix: true, allow_nil: true

    def liked_by?(user)
      likes.exists?(user: user)
    end

    def like_for(user)
      likes.find_by(user: user)
    end
end
