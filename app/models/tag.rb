class Tag < ApplicationRecord
  belongs_to :post

  has_many :favorites, as: :target, class_name: Action.name
end
