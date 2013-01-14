class Category < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :folders,class_name: "Folder", foreign_key: "category_id", dependent: :destroy
  validates :name, :presence => true, :uniqueness => true
end
