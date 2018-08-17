class TagsController < ApplicationController
  def show
    @tag = Tag.find_by id: params[:id]
    redirect_to root_path unless @tag.present?
    @posts = @tag.posts.page(params[:page]).per Settings.pagnation
  end
end
