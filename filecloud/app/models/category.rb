class Category < ActiveRecord::Base
  attr_accessible :description, :name
  validates :name, presence: true, length: { maximum:50 }
  validates :description, presence: true

  has_many :folders
end
