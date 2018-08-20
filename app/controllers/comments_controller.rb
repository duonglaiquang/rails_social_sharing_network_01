class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :find_post, only: [:create]
  before_action :find_comment, only: [:destroy]

  def create
    @comment = current_user.comments.build comment_params
    if @comment.save
      @comments = @post.comments.parent_nil.order_by_created_at
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
    params.require(:comment).permit :post_id, :user_id, :content, :parent_id,
      :reply_id
  end

  def find_post
    @post = Post.find_by id: params[:comment][:post_id]
    return if @post
    flash[:danger] = t "error"
    redirect_back fallback_location: request.referrer
  end

  def find_comment
    @comment = Comment.find_by id: params[:id]

    return if @comment
    flash[:danger] = t "error"
    redirect_back fallback_location: request.referrer
  end
end
