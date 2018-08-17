class StaticPagesController < ApplicationController
  def home
    @posts = Post.order(point: :desc).page(params[:page]).per Settings.pagnation
  end
end
