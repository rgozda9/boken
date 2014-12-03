ActiveAdmin.register_page "List Outstanding Orders" do
  
  content do
    render 'orders/list_orders', { :orders => Order.where('status LIKE ?', 'outstanding').order('customer_id') }
  end
end