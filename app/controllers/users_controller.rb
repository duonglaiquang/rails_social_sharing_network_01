class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(edit update)
  before_action :find_user, only: %i(show edit update)
  before_action :correct_user, only: %i(edit update)

  def index
    User.all.each do |f|
      f.point = 0
      f.posts.each do |t|
        f.point += t.point
      end
      f.save
    end
    @users = User.order(point: :desc).page(params[:page]).per Settings.pagnation
  end

  def show
    @posts = @user.posts
    @followings = @user.following
    @followers = @user.followers
    @posts_feed = @posts
    if @followings.any?
      @followings.each do |f|
        @posts_feed += f.posts
      end
    end
    return if @user&.activated
    redirect_to root_path
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "success"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :bio,
                                 :password_confirmation
  end

  def correct_user
    redirect_to home_path unless @user.current_user? current_user
  end
end
