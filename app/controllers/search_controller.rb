class SearchController < ApplicationController
  before_action :set_search
  attr_reader :users
  attr_reader :posts

  def search
    respond_to do |format|
      format.json{users}
      format.json{posts}
    end
  end

  private

  def set_search
    q = params[:q]
    @posts = Post.search(name_cont: q).result
    @users = User.search(email_cont: q).result
  end
end
