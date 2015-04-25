class UtilityTipsController < ApplicationController
  before_action :set_utility_tip, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin!

  # GET /utility_tips
  # GET /utility_tips.json
  def index
    @utility_tips = UtilityTip.all
  end

  def electricity
    @utility_tips = UtilityTip.where("utility_id = ?", 0)

    respond_to do |format|
      format.json{render json: @utility_tips.to_json}
    end
  end

  def water
    @utility_tips = UtilityTip.where("utility_id = ?", 1)

    respond_to do |format|
      format.json{render json: @utility_tips.to_json}
    end
  end

  def natural_gas
    @utility_tips = UtilityTip.where("utility_id = ?", 2)

    respond_to do |format|
      format.json{render json: @utility_tips.to_json}
    end
  end

  # GET /utility_tips/1
  # GET /utility_tips/1.json
  def show
  end

  # GET /utility_tips/new
  def new
    @utility_tip = UtilityTip.new
  end

  # GET /utility_tips/1/edit
  def edit
  end

  # POST /utility_tips
  # POST /utility_tips.json
  def create
    @utility_tip = UtilityTip.new(utility_tip_params)

    respond_to do |format|
      if @utility_tip.save
        format.html { redirect_to @utility_tip, notice: 'Utility tip was successfully created.' }
        format.json { render :show, status: :created, location: @utility_tip }
      else
        format.html { render :new }
        format.json { render json: @utility_tip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /utility_tips/1
  # PATCH/PUT /utility_tips/1.json
  def update
    respond_to do |format|
      if @utility_tip.update(utility_tip_params)
        format.html { redirect_to @utility_tip, notice: 'Utility tip was successfully updated.' }
        format.json { render :show, status: :ok, location: @utility_tip }
      else
        format.html { render :edit }
        format.json { render json: @utility_tip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /utility_tips/1
  # DELETE /utility_tips/1.json
  def destroy
    @utility_tip.destroy
    respond_to do |format|
      format.html { redirect_to utility_tips_url, notice: 'Utility tip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_utility_tip
      @utility_tip = UtilityTip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def utility_tip_params
      params.require(:utility_tip).permit(:id, :order, :text, :utility_id)
    end
end
