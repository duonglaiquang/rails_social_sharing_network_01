class LikesController < ApplicationController
  before_action :logged_in_user, :find_post, :instance_params, only: [:create]

  def create
    current_user.likes.each do |f|
      if (@type == 1 && f.post_id == @post.id) || (@type.zero? && f.comment_id == @comment.id)
        return destroy
      end
    end
    @like = current_user.likes.build like_params
    if @like.save
      if @type == 1
        @post.point += 1
        @post.save
      elsif @type.zero?
        @comment.point += 1
        @comment.save
      end
      respond_to do |format|
        format.html{redirect_back fallback_location: request.referrer}
        format.js
      end
    else
      flash[:danger] = t "error"
      redirect_back fallback_location: request.referrer
    end
  end

  def destroy
    if @type == 1
      @like = current_user.likes.find_by post_id: @post.id
      if @like.destroy
        @post.point -= 1
        @post.save
        respond_to do |format|
          format.html{redirect_back fallback_location: request.referrer}
          format.js
        end
      else
        flash[:danger] = t "error"
        render "posts/show"
      end
    elsif @type.zero?
      @like = current_user.likes.find_by comment_id: @comment.id
      if @like.destroy
        @comment.point -= 1
        @comment.save
        respond_to do |format|
          format.html{redirect_back fallback_location: request.referrer}
          format.js
        end
      else
        flash[:danger] = t "error"
        render "posts/show"
      end
    end
  end

  private

  def like_params
    params.require(:like).permit :post_id, :comment_id, :type_id
  end

  def find_post
    @post = Post.find_by id: params[:like][:post_id]
    return if @post
    flash[:danger] = t "error"
    redirect_back fallback_location: request.referrer
  end

  def instance_params
    @type = params[:like][:type_id].to_i
    if @type.zero?
      @comment = Comment.find_by id: params[:like][:comment_id]
      return if @comment
      flash[:danger] = t "error"
      redirect_back fallback_location: request.referrer
    end
  end
end
