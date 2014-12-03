class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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
        total += p.price
      end
    end
    total
  end
  helper_method :shopping_cart_total

  def logout
    session[:customer_id] = nil
  end
end
