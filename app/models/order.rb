class Order < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user
  belongs_to :shipper

  attr_accessor :rest_name
  attr_accessor :user_name
end
