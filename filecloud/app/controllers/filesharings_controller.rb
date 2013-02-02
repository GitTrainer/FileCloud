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
		@folder_id = Filestream.find(params[:filesharing][:file_id]).folder_id
		@file_id = params[:filesharing][:file_id]
#		list_users_shared = Filesharing.find_by_sql(["select shared_user_id from filesharings where file_id = ?", @file_id])
#		list_all_user = User.find_by_sql(["select id from users where id != ?", current_user.id])
#  	list_users_not_shared = list_all_user - list_users_shared
		activated_ids = params[:activated].collect {|id| id.to_i} if params[:activated]
#  	seen_ids = params[:seen].collect {|id| id.to_i} if params[:seen]
#  	if !seen_ids.nil?
		  if !activated_ids.nil?
#		    uncheck_ids = seen_ids - activated_ids
		 	  if Filesharing.where(:file_id => @file_id).exists?
			  	 Filesharing.delete_all(["file_id = ?", @file_id])
		 	  end
#	 	  binding.pry
#		 	   uncheck_ids.each do |uncheck|
#					if list_users_shared.include?(uncheck)
#						UserMailer.not_share_file(uncheck).deliver
#					end
#		 	  end
		    activated_ids.each do |activated_id|
#		      if list_users_not_shared.include?(activated_id)
#						UserMailer.share_file(activated_id).deliver
#      	  end
      	  @file_share = Filesharing.new(:file_id => @file_id, :shared_user_id => activated_id)
		      @file_share.save!
		      UserMailer.share_file(activated_id).deliver
		 	  end

		 	  redirect_to ("/folders/"+ @folder_id.to_s+"?&user_id="+current_user.id.to_s)
		  else
		 	  Filesharing.delete_all(["file_id = ?", @file_id])
		    redirect_to ("/folders/"+ @folder_id.to_s+"?&user_id="+current_user.id.to_s)
		  end
#	  end
	end


end
