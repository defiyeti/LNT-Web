class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:show, :stats]

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

    user = User.where("authentication_token = ? AND email = ?", token, email)

    respond_to do |format|
      format.json{render json: user.to_json(:include => [:stats])}
    end
	end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
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
      params.require(:user).permit(:uses_electricity, :uses_water, :uses_natural_gas, :zip_code, :id, :username, :password, :email, :oauth, :oauth_expire_at)
    end
end
