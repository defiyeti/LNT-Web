class StatsController < ApplicationController
  before_action :set_stat, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:create]
  # GET /stats/new
  def new
    @stat = Stat.new
  end

  # GET /stats/1/edit
  def edit
  end

  # POST /stats
  # POST /stats.json
  def create
    token = params[:user_token]
    email = params[:user_email]

    user = User.find_by(authentication_token: token, email: email)
    @stat = Stat.find_by(month: params[:month], year: params[:year], user: user)

    if !@stat.present?
	    @stat = user.stats.new
		end

		@stat.electricity_usage=params[:electricity_usage].to_i
		@stat.water_usage=params[:water_usage].to_i
		@stat.natural_gas_usage=params[:natural_gas_usage].to_i
		@stat.month=params[:month]
		@stat.year=params[:year]

    respond_to do |format|
      if @stat.save
        format.html { redirect_to @stat, notice: 'Stat was successfully created.' }
        format.json { render :show, status: :created, location: @stat }
      else
        format.html { render :new }
        format.json { render json: @stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stats/1
  # PATCH/PUT /stats/1.json
  def update
    respond_to do |format|
      if @stat.update(stat_params)
        format.html { redirect_to @stat, notice: 'Stat was successfully updated.' }
        format.json { render :show, status: :ok, location: @stat }
      else
        format.html { render :edit }
        format.json { render json: @stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stats/1
  # DELETE /stats/1.json
  def destroy
    @stat.destroy
    respond_to do |format|
      format.html { redirect_to stats_url, notice: 'Stat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stat
      @stat = Stat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stat_params
      params.require(:stat).permit(:id, :user_id, :electricity_usage, :water_usage, :natural_gas_usage, :month, :year)
    end
end
