class Folder < ActiveRecord::Base
  attr_accessible :category_id, :description, :name

  validates :name, presence:true
  validates :category_id, presence:true
  belongs_to :category
  has_many :file_up_loads
end
