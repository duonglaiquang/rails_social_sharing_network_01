class PostWorker
  include Sidekiq::Worker

  def perform post_id
    post = Post.find_by_id post_id

    return unless post
    if post.picture?
      @uploader = Cloudinary::Uploader.upload("public/" + post.picture.url)
      post.update_column :picture, @uploader["url"]
    end
    if post.video?
      @uploader = Cloudinary::Uploader.upload("public/" + post.video.url,
        resource_type: :video)
      post.update_column :video, @uploader["url"]
    end
  end
end
