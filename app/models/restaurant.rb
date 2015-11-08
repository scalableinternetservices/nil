class Restaurant < ActiveRecord::Base
  belongs_to :user
  has_many :foods
  has_many :comments
  
  # geocoded_by :address   # can also be an IP address
  # after_validation :geocode          # auto-fetch coordinates
  def self.search(search)
    if (search)
      where("name LIKE ?","%#{search}%")
    else
      find(:all)
    end
  end
end
