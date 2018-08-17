class PostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def index; end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build post_params
    if @post.save
      flash[:success] = t "posts.create.post_created"
      redirect_to @post
    else
      flash[:danger] = t "posts.create.post_create_failed"
      @posts = Post.all
      redirect_to root_path
    end
  end

  def show
    @post = Post.find_by id: params[:id]
    @comments = @post.comments.parent_nil.order_by_created_at
    @childs = @post.comments - @comments
  end

  def destroy
    @post.destroy
    flash[:success] = t "posts.destroy.post_deleted"
    redirect_to request.referrer || root_url
  end

  private

  def post_params
    params.require(:post).permit :content, :picture, :video, :upload_type, :title
  end

  def correct_user
    @post = current_user.posts.find_by id: params[:id]
    redirect_to root_url if @post.nil?
  end
end
