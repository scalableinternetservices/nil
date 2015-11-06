class Restaurant < ActiveRecord::Base
  belongs_to :user
  has_many :foods
  has_many :comments
  
  def self.search(search)
    if (search)
      where("name LIKE ?","%#{search}%")
    else
      find(:all)
    end
  end
end
