class Folder < ActiveRecord::Base
  attr_accessible :category_id, :description, :name
  belongs_to :category, class_name: "Category"
  validates :name, :presence => true, :uniqueness => true
  validates :category_id, :presence => true
end
