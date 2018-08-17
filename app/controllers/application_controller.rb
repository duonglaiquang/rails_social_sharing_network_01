class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :new_post

  def default_url_options
    {locale: I18n.locale}
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  private

  def logged_in_user
    return if user_signed_in?
    flash[:danger] = t "please_login"
    redirect_to new_user_session_path
  end

  def new_post
    @post = Post.new
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "user_not_found"
    redirect_to root_path
  end

  def check_admin
    redirect_to root_path unless current_user.admin?
  end
end
