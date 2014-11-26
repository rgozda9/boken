class ProvincesController < ApplicationController
  before_action :set_province, only: [:show, :edit, :update, :destroy]

  # GET /provinces
  # GET /provinces.json
  def index
    @provinces = Province.all
  end

  # GET /provinces/1
  # GET /provinces/1.json
  def show
  end

  # GET /provinces/new
  def new
    @province = Province.new
  end

  # GET /provinces/1/edit
  def edit
  end

  # POST /provinces
  # POST /provinces.json
  def create # rubocop:disable MethodLength
    @province = Province.new(province_params)
    respond_to do |format|
      if @province.save
        format.html do
          redirect_to @province, notice: 'Province was successfully created.'
        end
        format.json { render :show, status: :created, location: @province }
      else
        format.html { render :new }
        format.json do
          render json: @province.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /provinces/1
  # PATCH/PUT /provinces/1.json
  def update # rubocop:disable MethodLength
    respond_to do |format|
      if @province.update(province_params)
        format.html do
          redirect_to @province, notice: 'Province was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @province }
      else
        format.html { render :edit }
        format.json do
          render json: @province.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /provinces/1
  # DELETE /provinces/1.json
  def destroy
    @province.destroy
    respond_to do |format|
      format.html do
        redirect_to provinces_url,
                    notice: 'Province was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_province
    @province = Province.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list
  # through.
  def province_params
    params.require(:province).permit(:name, :pst, :gst, :hst)
  end
end
