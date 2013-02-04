class Category < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :folders,class_name: "Folder", foreign_key: "category_id", dependent: :destroy
  validates :name, :presence => true, :uniqueness => true
  validates :description, :presence => true

 

searchable :auto_index => true, :auto_remove => true do 
    text :name ,:boost => 5
    
    
  
  end
  # def to_s
  #   self.name
  # end
end
