class Restaurant < ActiveRecord::Base
  belongs_to :user
  has_many :foods
  has_many :comments
  
  geocoded_by :address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
  def self.search(search)
    ids = Rails.cache.fetch("search-rest-#{search}") do
      if (search)
        Restaurant.where("name LIKE ?","%#{search}%").pluck(:id)
      else
        Restaurant.find(:all).pluck(:id)
      end
    end
    find(ids)
  end
end
