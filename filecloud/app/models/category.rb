class Category < ActiveRecord::Base
  attr_accessible :description, :name

  validates :name , presence: true
  has_many :folders,dependent: :destroy
end
