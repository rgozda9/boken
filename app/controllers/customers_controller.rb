class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
    session[:redirect] = false
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
    @provinces = Province.all
  end

  def add_to_session
    if !params[:username].nil? && !params[:password].nil?
      customer = Customer.select('id').where("username = ?", params[:username]).where("password = ?", params[:password])
      session[:customer_id] = customer
      flash[:notice] = "You have successfully logged in."
      redirect_to boken_path
    end
  end
  helper_method :add_to_session

  def redirect
    redirect_to checkout_path
  end
  helper_method :redirect
  # def add_to_session
  #   session[:customer_id] = @customer.id
  #   flash[:notice] = "You have successfully signed up."
  #   redirect_to boken_path
  # end

  # GET /customers/1/edit
  def edit
    @provinces = Province.all
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)
    @provinces = Province.all

    respond_to do |format|
      if @customer.save
        format.html { redirect_to login_path, notice: 'You have successfully signed up. Please log in.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :address, :city, :country_name, :postal_code, :email, :province_id, :username, :password)
    end
end
