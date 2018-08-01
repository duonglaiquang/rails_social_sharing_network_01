module PostsHelper
  def post_video_id post
    post[:video].split("/").last.split(".").first
  end

  def post_image_id post
    post[:picture].split("/").last.split(".")
  end

  def change_gif_link_to_mp4 post
    post[:picture].split("gif").first + "mp4"
  end
end
