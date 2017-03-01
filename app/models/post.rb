class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :comments, lambda { order(created_at: :desc) }, dependent: :destroy

    delegate :name, to: :category, prefix: true, allow_nil: true
end
