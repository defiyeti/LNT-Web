class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :destroy]
  before_filter :authenticate_user!, except: [:show, :stats, :update]

  # POST /users
  # POST /users.json
  def create
    @user = User.new
		@user.email = params[:user][:email]
		@user.password = params[:user][:password]
		@user.zip_code = params[:user][:zip_code]
		@user.uses_electricity = params[:user][:uses_electricity]
		@user.uses_water = params[:user][:uses_water]
		@user.uses_natural_gas = params[:user][:uses_natural_gas]

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # Password recovery option
  def generate_new_password_email
    user = User.find(params[:user_id])
    user.send_reset_password_instructions
    flash[:notice] = "Reset password instructions have been sent to your email"
    redirect_to admin_user_path(user)
  end

  # Get /stats/user_id.json
  def stats
    token = params[:user_token]
    email = params[:user_email]

    user = User.find_by(authentication_token: token, email: email)

    respond_to do |format|
      format.json{render json: user.to_json(:methods => [:carbon_footprint, :carbon_ranking, :electricity_ranking, :water_ranking, :natural_gas_ranking, :last_twelve_months])}
    end
  end

	def show
    token = params[:user_token]
    email = params[:user_email]

    user = User.find_by(authentication_token: token, email: email)

    respond_to do |format|
      format.json{render json: user.to_json(:include => [:stats])}
    end
	end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
		id = params[:id]	
    token = params[:user_token]
    email = params[:user_email]

    @user = User.find_by(authentication_token: token, email: email)
    respond_to do |format|
			if @user.present? and @user.update(params.require(:user).permit(:uses_electricity, :uses_water, :uses_natural_gas, :zip_code, :email, :password))
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render json: @user.to_json }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:uses_electricity, :uses_water, :uses_natural_gas, :zip_code, :password, :email, :oauth, :oauth_expire_at)
    end
end
