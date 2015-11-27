class Food < ActiveRecord::Base
    belongs_to :restaurant
    
    def self.search(search)
      Rails.cache.fetch("search-food-#{search}") do
        if (search)
          Food.where("name LIKE ?","%#{search}%").all
        else
          Food.find(:all).all
        end
      end
    end
end
