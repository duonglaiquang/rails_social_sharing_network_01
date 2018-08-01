class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: :destroy

  def index
    @users = User.order(:created_at).page(params[:page]).per Settings.pagnation
  end

  def destroy
    if @user.destroy
      flash[:success] = t "success"
      redirect_to admin_users_path
    else
      flash[:alert] = t "error"
    end
  end
end
