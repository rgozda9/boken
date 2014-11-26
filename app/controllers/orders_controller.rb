class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @customers = Customer.all
  end

  # GET /orders/1/edit
  def edit
    @customers = Customer.all
  end

  # POST /orders
  # POST /orders.json
  def create # rubocop:disable MethodLength
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html do
          redirect_to @order, notice: 'Order was successfully created.'
        end
        format.json { render :show, status: :created, location: @order }
      else
        @customers = Customer.all
        format.html { render :new }
        format.json do
          render json: @order.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update # rubocop:disable MethodLength
    respond_to do |format|
      if @order.update(order_params)
        format.html do
          redirect_to @order, notice: 'Order was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @order }
      else
        @customers = Customer.all
        format.html { render :edit }
        format.json do
          render json: @order.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html do
        redirect_to orders_url, notice: 'Order was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  def checkout
    @products = Product.all
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list
  # through.
  def order_params
    params.require(:order).permit(:pst_rate, :gst_rate, :hst_rate, :status,
                                  :customer_id, :address, :city,
                                  :country_name, :postal_code)
  end
end
