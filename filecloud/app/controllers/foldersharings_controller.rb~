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
		 #@new_foldersharing = Foldersharing.new(params[:foldersharing])
		 @user_ids = params[:list_user_id]
		 @folder_id =  params[:foldersharing][:folder_id]
		 if !@user_ids.nil?
		    @user_ids.each do |user_id|
		 	@folder_share = Foldersharing.new(:folder_id => params[:foldersharing][:folder_id], :shared_user_id => user_id)
		 	@folder_share.save!
			@delete_folder = Foldersharing.find_by_sql(["select * from foldersharings where foldersharings.folder_id = ? and foldersharings.shared_user_id != ?",@folder_id,user_id])
			binding.pry
#			if !@delete_folder.nil?
#				@delete_folder.each do |del|
#					del.destroy
#				end
#			end
		 	end
		 	redirect_to "/folders/"+ @folder_id.to_s
		 else
		 	flash[:notice] = "Please choose member(s) to share. If not, click Back to back to folder"
		 	redirect_to "/foldersharings/?folder_id="+ @folder_id.to_s
		 end

	end


end
