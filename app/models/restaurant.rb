class Restaurant < ActiveRecord::Base
  belongs_to :user
  has_many :foods
  
  def self.search(search)
    if (search)
      where("name LIKE ?","%#{search}%")
    else
      find(:all)
    end
  end
end
