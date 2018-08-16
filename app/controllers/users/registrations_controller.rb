class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
    return unless resource
    resource.save
  end

  private

  def sign_up_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
