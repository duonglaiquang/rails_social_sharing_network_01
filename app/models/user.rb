class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :actions, as: :target
  has_many :notifications, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
           foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
           foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
end
