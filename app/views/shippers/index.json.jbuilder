json.array!(@shippers) do |shipper|
  json.extract! shipper, :id, :name, :address, :zip, :user_id
  json.url shipper_url(shipper, format: :json)
end
