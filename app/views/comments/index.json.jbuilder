json.array!(@comments) do |comment|
  json.extract! comment, :id, :message, :restaurant_id, :customer_id
  json.url comment_url(comment, format: :json)
end
