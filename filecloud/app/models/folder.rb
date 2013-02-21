class Folder < ActiveRecord::Base
  attr_accessible :category_id, :description, :name, :user_id, :parentID
  validates :name, :presence => true, :uniqueness => true
  validates :category_id, :presence => true
  validates :description, :presence => true
  belongs_to :category, class_name: "Category"
  belongs_to :user
  has_many :filestreams, class_name: "Filestream", foreign_key: "folder_id", dependent: :destroy
  has_many :foldersharings, class_name: "Foldersharing", foreign_key: "folder_id", dependent: :destroy


# def self.search(search)
#   if search
#     where('name LIKE ?', "%#{search}%")
#   else
#     scoped
#   end
# end

def self.search(search)
  if search
    find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  else
    find(:all)
  end
end



end
