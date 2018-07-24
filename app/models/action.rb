class Action < ApplicationRecord
  enum vote_type: {downvote: 0, upvote: 1}
  enum favorite: {unfavorite: 0, favorite: 1}

  belongs_to :target, polymorphic: true
  belongs_to :user
end
