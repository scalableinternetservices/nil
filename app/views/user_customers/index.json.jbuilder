json.array!(@user_customers) do |user_customer|
  json.extract! user_customer, :id, :name, :address, :zipcode, :phone
  json.url user_customer_url(user_customer, format: :json)
end
