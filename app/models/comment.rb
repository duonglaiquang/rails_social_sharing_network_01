class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  has_many :votes, as: :target, class_name: Action.name
end
