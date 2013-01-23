class FoldersharingsController < ApplicationController
	def index
		@users = User.all
		if ( @new_foldersharing.nil?)
	  @new_foldersharing = Foldersharing.new
	end
          respond_to do |format|
             format.html { render action: "index"}
              format.js {render js: @new_foldersharing }
               format.js {render js:  @users }
             end
	end
end
