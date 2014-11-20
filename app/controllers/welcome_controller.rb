class WelcomeController < ApplicationController
  def index
    #session[:product_id] = nil
    #session[:customer_id] = nil
    #session[:redirect] = nil
  	@filterrific = Filterrific.new( 
      Product, 
      params[:filterrific] || session[:filterrific_products] 
    ) 

	@products = Product.filterrific_find(@filterrific).per_page_kaminari(params[:page]).per(10)

	  respond_to do |format|
	    format.html
	    format.js
	  end
  end

  def reset_filterrific 
    session[:filterrific_products] = nil 
    redirect_to :action => :index 
  end

  def shopping_cart_items
    count = 0
    if session[:product_id].nil?
      count = 0
    else
      count = session[:product_id].count
    end
    count
  end
  helper_method :shopping_cart_items

  def shopping_cart_total
    total = 0
    if session[:product_id].nil?
      total = 0.00
    else
      session[:product_id].each do |product|
        p = Product.find(product)
        total = total + p.price
      end
    end
    total
  end
  helper_method :shopping_cart_total

  # def add_to_session
  #   customer = Customer.find(params[:id]).where("username = ?", params[:username]).where("password = ?", params[:password])
  #   session[:customer_id] = customer
  #   flash[:notice] = "You have successfully signed up."
  #   redirect_to boken_path
  # end

  # def sign_up
  #   @provinces = Province.all
  #   @customer = Customer.new
  # end
end
