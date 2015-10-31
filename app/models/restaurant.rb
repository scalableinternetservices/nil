class Restaurant < ActiveRecord::Base
  belongs_to :user
  has_many :foods
  has_many :comments
end
