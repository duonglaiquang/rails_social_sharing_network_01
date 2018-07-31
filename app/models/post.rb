class Post < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  mount_uploader :video, VideoUploader
  validates :content, presence: true
  has_many :notifications, dependent: :destroy
  has_many :tags
  has_many :comments, dependent: :destroy
  has_many :votes, as: :target, class_name: Action.name
  after_commit :upload_sidekiq, on: :create

  private

  def upload_sidekiq
    PostWorker.perform_async id
  end
end
