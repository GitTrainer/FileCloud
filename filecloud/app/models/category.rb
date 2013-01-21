class Category < ActiveRecord::Base
  attr_accessible :description, :name

  validates :name , presence: true
  validates :name , :length=>{:minimum=>2,:maximum=>50}
  validates :name, uniqueness: true
  has_many :folders,dependent: :destroy
end
