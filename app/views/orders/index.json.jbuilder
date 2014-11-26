json.array!(@orders) do |order|
  json.extract! order, :id, :pst_rate, :gst_rate, :hst_rate, :status,
                :customer_id
  json.url order_url(order, format: :json)
end
