class Tag < ApplicationRecord
  has_many :posts
  has_many :favorites, as: :target, class_name: Action.name
end
