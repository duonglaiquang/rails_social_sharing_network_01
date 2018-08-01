class Admin::PostsController < Admin::BaseController
  def index
    @posts = Post.all.page(params[:page]).per Settings.pagnation
  end

  def destroy
    @post = Post.find_by id: params[:id]
    if @post.destroy
      flash[:success] = t "success"
    else
      flash[:alert] = t "error"
    end
    redirect_to request.referrer || root_url
  end
end
