class FolderchildsController < ApplicationController
  before_filter :signed_in_user

  def index
		if @new_folderchild.nil?
		  @new_folderchild = Folderchild.new
		end
		@foldertree = Folder.find(params[:pID])
		 	respond_to do |format|
				format.html { render action: "index"}
				format.js {render js: @new_folderchild }
			  format.js {render js: @foldertree }
			end
  end
end
