class Customer < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  # geocoded_by :address   # can also be an IP address
  # after_validation :geocode          # auto-fetch coordinates
end
