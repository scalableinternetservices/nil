json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :id, :name, :address, :zip, :phone, :user_id
  json.url restaurant_url(restaurant, format: :json)
end
