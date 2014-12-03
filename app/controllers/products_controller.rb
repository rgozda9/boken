class ProductsController < ApplicationController # rubocop:disable ClassLength
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    @products = Product.order(:name).per_page_kaminari params[:page]
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  def add_to_session # rubocop:disable all
    session[:product_id] ||= []
    if session[:product_id].include?(Product.find(params[:id]).id)
       
      flash[:notice] = 'You have already added this item to your cart.'
    else
      session[:product_id] << Product.find(params[:id]).id
      flash[:notice] = 'You have successfully added this item to your cart.'
    end
    redirect_to product_path(id: params[:id])
  end

  def checkout # rubocop:disable all
    if session[:customer_id].nil?
      session[:redirect] = true
      redirect_to login_path
    elsif !session[:product_id].nil?
      @products = Product.find(session[:product_id])
      @customer = Customer.find(session[:customer_id])
    end
  end

  # def create_session
  #   Session.create(:order_id => order_id)
  # end

  def invoice # rubocop:disable all
    @province = Province.find(params[:province])
    @customer = Customer.find(session[:customer_id])
    customer_order = @customer.orders.build
    customer_order.status = 'outstanding'
    customer_order.pst_rate = @customer.province.pst
    customer_order.gst_rate = @customer.province.gst
    customer_order.hst_rate = @customer.province.hst
    customer_order.address = params[:address]
    customer_order.city = params[:city]
    customer_order.province = params[:province]
    customer_order.country_name = params[:country_name]
    customer_order.postal_code = params[:postal_code]
    customer_order.save

    session[:order_id] = customer_order.id
    session[:product_id].each do |product_id|
      product = Product.find(product_id)
      customer_item = customer_order.lineItems.build
      customer_item.order_id = customer_order.id
      customer_item.price = product.price
      customer_item.quantity = params["quantity_#{product.id}"]
      customer_item.product_id = product.id
      customer_item.save
    end
    @line_items = LineItem.where('order_id = ?', session[:order_id])
    session[:order_complete] = true
  end

  def display_periods(line_item)
    '.' * (100 - line_item.product.name.size)
  end
  helper_method :display_periods

  def total id
    price = LineItem.select('price').where('order_id = ?', session[:order_id]).where('product_id = ?', id).first.price
    quantity = LineItem.select('quantity').where('order_id = ?',
                                                 session[:order_id]).where('product_id = ?', id).first.quantity
    total =  price * quantity
    total
  end
  helper_method :total

  def sub_total
    total = 0
    line_item = LineItem.where('order_id = ?', session[:order_id])
    line_item.each do |item|
      total += item.price * item.quantity
    end
    total
  end
  helper_method :sub_total

  def pst
    pst = Order.select('pst_rate').where('id = ?', session[:order_id]).first.pst_rate
    pst
  end
  helper_method :pst

  def pst_total
    sub_total * pst
  end
  helper_method :pst_total

  def hst
    hst = Order.select('hst_rate').where('id = ?', session[:order_id]).first.hst_rate
    hst
  end
  helper_method :hst

  def hst_total
    sub_total * hst
  end
  helper_method :hst_total

  def gst
    gst = Order.select('gst_rate').where('id = ?', session[:order_id]).first.gst_rate
    gst
  end
  helper_method :gst

  def gst_total
    sub_total * gst
  end
  helper_method :gst_total

  def grand_total
    final = sub_total
    final += pst * sub_total unless pst.zero?
    final += gst * sub_total unless gst.zero?
    final += hst * sub_total unless hst.zero?
    final
  end
  helper_method :grand_total

  # GET /products/new
  def new
    @product = Product.new
    @categories = Category.all
  end

  # GET /products/1/edit
  def edit
    @categories = Category.all
  end

  # POST /products
  # POST /products.json
  def create # rubocop:disable MethodLength
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html do
          redirect_to @product, notice: 'Product was successfully created.'
        end
        format.json { render :show, status: :created, location: @product }
      else
        @categories = Category.all
        format.html { render :new }
        format.json do
          render json: @product.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update # rubocop:disable MethodLength
    respond_to do |format|
      if @product.update(product_params)
        format.html do
          redirect_to @product,
                      notice: 'Product was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @product }
      else
        @categories = Category.all
        format.html { render :edit }
        format.json do
          render json: @product.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html do
        redirect_to products_url,
                    notice: 'Product was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list
  # through.
  def product_params
    params.require(:product).permit(:name, :description, :price,
                                    :stock_quantity, :on_sale, :sale_price,
                                    :status, :image, :rating, :category_id,
                                    :genre, :province)
  end
end
