class FilesharingsController < ApplicationController
	def index
			@users = User.find_by_sql(["select * from users where users.id != ?",current_user])
			if ( @new_filesharing.nil?)
				@new_filesharing = Filesharing.new
			end
      respond_to do |format|
        format.html { render action: "index"}
        format.js {render js: @new_filesharing }
        format.js {render js:  @users }
      end
	end

	def create
		seen_ids = params[:seen].collect {|id| id.to_i} if params[:seen]
		if !seen_ids.nil?
			@folder_id = Filestream.find(params[:filesharing][:file_id]).folder_id
			@file_id = params[:filesharing][:file_id]
			activated_ids = params[:activated].collect {|id| id.to_i} if params[:activated]
		  if !activated_ids.nil?
		 	  if Filesharing.where(:file_id => @file_id).exists?
			  	 Filesharing.delete_all(["file_id = ?", @file_id])
		 	  end
		    activated_ids.each do |activated_id|
      	  @file_share = Filesharing.new(:file_id => @file_id, :shared_user_id => activated_id)
		      @file_share.save!
		      UserMailer.share_file(activated_id,@file_id).deliver
		 	  end
		 	  flash[:success] = "Share file successfully"
		 	  redirect_to ("/folders/"+ @folder_id.to_s)
		  else
		 	  Filesharing.delete_all(["file_id = ?", @file_id])
		 	  flash[:success] = "Successfully share file to no member"
		    redirect_to ("/folders/"+ @folder_id.to_s)
		  end
		else
			@id = params[:filesharing][:folder_id].to_i
			flash[:notice] = "No member to share"
			redirect_to "/folders/#{@id}"
	  end
	end
end
