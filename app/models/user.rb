class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :name, :phone, :zip, :address
  validates :role, inclusion: {in: %w(customer restaurant shipper)}
  validates :name, presence: true
  validates :phone, presence: true
  validates :zip, presence: true
  validates :address, presence: true
  before_validation {self.role.downcase!}
end
