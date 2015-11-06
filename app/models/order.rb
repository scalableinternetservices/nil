class Order < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user
  belongs_to :shipper
end
