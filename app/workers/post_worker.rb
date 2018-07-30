class PostWorker
  include Sidekiq::Worker

  def perform post_id
    post = Post.find_by_id post_id

    return unless post
    @uploader = Cloudinary::Uploader.upload("public/" + post.video.url,
      resource_type: :video)
    post.update_column :video, @uploader["url"]
  end
end
