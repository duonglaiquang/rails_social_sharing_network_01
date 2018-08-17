class Post < ApplicationRecord
  enum upload_type: {picture: 0, video: 1, seed: 2}

  belongs_to :user
  belongs_to :tag, optional: true
  mount_uploader :picture, PictureUploader
  mount_uploader :video, VideoUploader
  has_many :notifications, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, as: :target, class_name: Action.name
  # after_commit :upload_sidekiq, on: :create

  private

  def upload_sidekiq
    PostWorker.perform_async id
  end
end
