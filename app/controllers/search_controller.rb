class SearchController < ApplicationController
  attr_reader :users
  attr_reader :posts

  def search
    @users = User.search params[:q]
    @posts = Post.search params[:q]

    respond_to do |format|
      format.json{users}
      format.json{posts}
    end
  end

end
