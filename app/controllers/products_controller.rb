class ProductsController < ApplicationController
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

  def add_to_session
    session[:product_id] ||= []
    session[:product_id] << Product.find(params[:id]).id
    flash[:notice] = "You have successfully added this item to your cart."
    redirect_to product_path(id: params[:id])
  end

  def redirect
    session[:redirect] = true
    redirect_to login_path
  end
  helper_method :redirect

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
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        @categories = Category.all
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        @categories = Category.all
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def checkout
    if params[:id] != nil
      @product = Product.find(params[:id])
    else
      @products = Product.all
    end
    # if session[:product_id] != nil
    #   session[:product_id].each do |product|
    #     @products = Product.find(product)
    #   end
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :price, :stock_quantity, :on_sale, :sale_price, :status, :image, :rating, :category_id, :genre)
    end
end
