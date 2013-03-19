class Category < ActiveRecord::Base
	extend FriendlyId
	friendly_id :name
  attr_accessible :description, :name
  has_many :folders,class_name: "Folder", foreign_key: "category_id", dependent: :destroy
  validates :name, :presence => true, :uniqueness => true
  validates :description, :presence => true



def self.search(search)
  if search
    find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  else
    find(:all)
  end
end


  # def to_s
  #   self.name
  # end
end
