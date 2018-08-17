class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  has_many :votes, as: :target, class_name: Action.name

  scope :order_by_created_at, ->{order created_at: :desc}
  scope :parent_nil, ->{where parent_id: nil}
end
