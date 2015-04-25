class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :zip_code, :uses_electricity, :uses_water, :uses_natural_gas)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :zip_code, :uses_electricity, :uses_water, :uses_natural_gas)
  end
end
