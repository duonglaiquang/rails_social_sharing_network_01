class Post < ApplicationRecord
  belongs_to :user

  has_many :notifications, dependent: :destroy
  has_many :tags
  has_many :comments, dependent: :destroy
  has_many :votes, as: :target, class_name: Action.name
end
