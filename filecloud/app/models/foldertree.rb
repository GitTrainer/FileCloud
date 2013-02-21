class Foldertree < ActiveRecord::Base
  attr_accessible :parentID, :name, :description
   validates :name, :presence => true, :uniqueness => true
   validates :description, :presence => true
end
