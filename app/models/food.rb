class Food < ActiveRecord::Base
    belongs_to :restaurant
    
  def self.search(search)
      if (search)
        Food.where("name LIKE ?","%#{search}%")
      else
        Food.find(:all)
      end
  end
end
