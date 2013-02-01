class Category < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :folders,class_name: "Folder", foreign_key: "category_id", dependent: :destroy
  validates :name, :presence => true, :uniqueness => true
  validates :description, :presence => true



  searchable :auto_index => false, :auto_remove => false do
    string :name
  end
 

end
