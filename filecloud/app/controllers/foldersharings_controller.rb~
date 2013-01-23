class FoldersharingsController < ApplicationController
	def index
		@users = User.find_by_sql(["select * from users where users.id != ?",current_user])
		if ( @new_foldersharing.nil?)
	  @new_foldersharing = Foldersharing.new
	end
          respond_to do |format|
             format.html { render action: "index"}
              format.js {render js: @new_foldersharing }
               format.js {render js:  @users }
             end
	end

	def new
	@users = User.find_by_sql(["select * from users where users.id != ?",current_user])
		 @new_foldersharing = Foldersharing.new
	end

   def create
	   @users = User.find_by_sql(["select * from users where users.id != ?",current_user])
		 activated_ids = params[:activated].collect {|id| id.to_i} if params[:activated]
		 @folder_id =  params[:foldersharing][:folder_id]
		 if !activated_ids.nil?
		 	 if Foldersharing.where(:folder_id => @folder_id).exists?
			 	 Foldersharing.delete_all(["folder_id = ?", @folder_id])
		 	 end
		   	     activated_ids.each do |activated_id|
		 	    	@folder_share = Foldersharing.new(:folder_id => params[:foldersharing][:folder_id], :shared_user_id => activated_id)
		     	 	@folder_share.save!
		 		 end
		 		 redirect_to "/folders/"+ @folder_id.to_s
		 else
		 	 flash[:notice] = "Please choose member(s) to share. If not, click Back to Folder"
		 	 redirect_to "/foldersharings/?folder_id="+ @folder_id.to_s
		 end

	end


end
