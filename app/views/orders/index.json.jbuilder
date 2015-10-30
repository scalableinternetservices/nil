json.array!(@orders) do |order|
  json.extract! order, :id, :price, :paid, :ready, :assigned, :arrived, :address, :zip, :phone, :shipped_at, :arrived_at, :confirmed_at, :restaurant_id, :customer_id
  json.url order_url(order, format: :json)
end
