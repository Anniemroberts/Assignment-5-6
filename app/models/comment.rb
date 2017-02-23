class Comment < ApplicationRecord
  belongs_to :post
  validates :body, presence: true, length: { minimum: 4 }
end
