class Folder < ActiveRecord::Base
  attr_accessible :description, :name, :category_id
  validates :name, presence: true
  validates :description, presence: true

  belongs_to :category
end
