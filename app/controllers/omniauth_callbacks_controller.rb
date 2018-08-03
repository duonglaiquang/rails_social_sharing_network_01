class OmniauthCallbacksController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth auth
    if @user.persisted?
      log_in @user
      flash[:success] = t "success", s: auth.provider
    else
      flash[:notice] = t("error") + @user.errors.full_messages.join
    end
    redirect_to root_path
  end

  def failure
    flash[:notice] = t "error"
    redirect_to root_path
  end
end
