class Comment < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :customer
end
