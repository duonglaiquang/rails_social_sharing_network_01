class TagsController < ApplicationController
  def show
    @tag = Tag.find_by id: params[:id]
    @posts = Post.where(tag_id: @tag.id).page(params[:page]).per Settings.pagnation
  end
end
