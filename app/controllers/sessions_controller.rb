class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by email: params[:session][:email].downcase
    if @user&.authenticate params[:session][:password]
      if @user.activated?
        log_in @user
        redirect_to @user
      else
        flash[:warning] = t "sessions.create.account_not_activated"
        redirect_to root_url
      end
    else
      flash.now[:danger] = t "error"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
