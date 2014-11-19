json.array!(@customers) do |customer|
  json.extract! customer, :id, :first_name, :last_name, :address, :city, :country_name, :postal_code, :email, :province_id
  json.url customer_url(customer, format: :json)
end
