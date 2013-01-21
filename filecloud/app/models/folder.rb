class Folder < ActiveRecord::Base
  attr_accessible :category_id, :description, :name

  validates :name, presence:true
  validates :category_id, presence:true
  validates :name, :length=>{:minimum=>2,:maximum=>50}
  validates :name, uniqueness:true
  belongs_to :category
  has_many :file_up_loads,dependent: :destroy
end
