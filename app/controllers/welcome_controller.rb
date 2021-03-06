class WelcomeController < ApplicationController
  def index
    session[:product_id] = nil if session[:order_complete] == true
    # session[:customer_id] = nil
    # session[:redirect] = nil
    session[:order_complete] = nil if session[:product_id] == nil
    @filterrific = Filterrific.new(
      Product,
      params[:filterrific] || session[:filterrific_products]
    )

    @products = Product.filterrific_find(@filterrific)
                .per_page_kaminari(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def reset_filterrific
    session[:filterrific_products] = nil
    redirect_to action: :index
  end

  # def add_to_session
  #   customer = Customer.find(params[:id]).where("username = ?",
  #              params[:username]).where("password = ?", params[:password])
  #   session[:customer_id] = customer
  #   flash[:notice] = "You have successfully signed up."
  #   redirect_to boken_path
  # end

  # def sign_up
  #   @provinces = Province.all
  #   @customer = Customer.new
  # end
end
