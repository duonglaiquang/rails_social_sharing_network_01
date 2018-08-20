class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  belongs_to :reply, class_name: Comment.name, foreign_key: :reply_id, optional: true

  has_many :likes, dependent: :destroy

  scope :order_by_created_at, ->{order created_at: :desc}
  scope :parent_nil, ->{where parent_id: nil}

  validates :content, presence: true
end
