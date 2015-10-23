json.array!(@customers) do |customer|
  json.extract! customer, :id, :name, :address, :zip, :phone, :user_id
  json.url customer_url(customer, format: :json)
end
