class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(edit update)
  before_action :find_user, only: %i(show edit update)
  before_action :correct_user, only: %i(edit update)

  def index
    @users = User.order(:name).page(params[:page]).per Settings.pagnation
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".please_check_mail"
      redirect_to root_url
    else
      flash[:danger] = t "error"
      render :new
    end
  end

  def show
    @posts = @user.posts
    @followings = @user.following
    @followers = @user.followers
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
