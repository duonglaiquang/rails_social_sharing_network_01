class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :find_comment, only: [:destroy]
  before_action :find_post, only: [:create]

  def create
    @comment = current_user.comments.build comment_params
    @comment.post = @post
    @comment.parent_id = params[:parent_id] if params[:parent_id].present?
    if @comment.save
      @comments = @post.comments.where(parent_id: nil).order_by_created_at
      @childs = @post.comments - @comments
      respond_to do |format|
        format.html{redirect_to @post}
        format.js
      end
    else
      flash[:danger] = t "error"
      render "posts/show"
    end
  end

  def destroy
    @childs = Comment.find_by parent_id: @comment.id
    @post = @comment.post
    if @comment.destroy
      @childs.destroy if @childs.present?
      respond_to do |format|
        format.html{redirect_to @post}
        format.js
      end
    else
      flash[:danger] = t "error"
      render "posts/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit :post_id, :user_id, :content
  end

  def find_post
    @post = Post.find_by id: params[:post_id]
    return if @post
    flash[:danger] = t "error"
    redirect_to root_path
  end

  def find_comment
    find_post
    @comment = Comment.find_by id: params[:id]
    return if @comment
    flash[:danger] = t "error"
    redirect_to @post
  end
end
