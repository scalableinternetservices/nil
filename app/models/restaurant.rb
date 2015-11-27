class Restaurant < ActiveRecord::Base
  belongs_to :user
  has_many :foods
  has_many :comments
  
  geocoded_by :address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
  def self.search(search)
    Rails.cache.fetch("search-rest-#{search}") do
      if (search)
        Restaurant.where("name LIKE ?","%#{search}%").all
      else
        Restaurant.find(:all).all
      end
    end
  end
end
