class Food < ActiveRecord::Base
    belongs_to :restaurant
    
    def self.search(search)
        if (search)
          where("name LIKE ?","%#{search}%")
        else
          find(:all)
        end
    end
end
