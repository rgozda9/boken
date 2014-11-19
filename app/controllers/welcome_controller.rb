class WelcomeController < ApplicationController
  def index
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

  def sign_up
    @provinces = Province.all
    @customer = Customer.new
  end
end
