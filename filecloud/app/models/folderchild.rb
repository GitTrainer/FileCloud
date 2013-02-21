class Folderchild < ActiveRecord::Base
	self.table_name = 'folderchilds'
	self.primary_key = 'id'
   attr_accessible :parentID, :name, :description
   validates :name, :presence => true, :uniqueness => true
   validates :description, :presence => true
end
