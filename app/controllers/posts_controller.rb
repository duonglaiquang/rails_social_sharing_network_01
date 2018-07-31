class PostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build post_params
    if @post.save
      flash[:success] = t ".post_created"
      redirect_to root_url
    else
      flash[:danger] = t ".post_create_failed"
      @feed_items = Post.all
      render "static_pages/home"
    end
  end

  def destroy
    @post.destroy
    flash[:success] = t ".post_deleted"
    redirect_to request.referrer || root_url
  end

  private

  def post_params
    params.require(:post).permit :content, :picture, :video
  end

  def correct_user
    @post = current_user.posts.find_by id: params[:id]
    redirect_to root_url if @post.nil?
  end
end
