json.array!(@foods) do |food|
  json.extract! food, :name, :price, :restaurant_id, :description
  json.url food_url(food, format: :json)
end
