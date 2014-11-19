json.array!(@products) do |product|
  json.extract! product, :id, :name, :description, :price, :stock_quantity, :on_sale, :sale_price, :status, :image, :rating, :category, :genre
  json.url product_url(product, format: :json)
end
