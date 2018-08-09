class Post < ApplicationRecord
  enum upload_type: {pic: 0, vid: 1, seed: 2}

  belongs_to :user
  belongs_to :tag, optional: true
  mount_uploader :picture, PictureUploader
  mount_uploader :video, VideoUploader
  has_many :notifications, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, as: :target, class_name: Action.name
end
