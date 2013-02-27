class FileSharesController < ApplicationController

    before_filter :signed_in_user
    before_filter :correct_user_for_show_file_shared,only:[:show]

    def show
     	@file_share=FileShare.find(params[:id])
    end

    def create
    	activated_ids = params[:activated].collect {|id| id.to_i} if params[:activated]
    	if !activated_ids.nil?
    	    activated_ids.each do |id|
    	       FileShare.find_by_user_id(id).destroy
            end
        end
    	file_up_load =FileUpLoad.find_by_id(params[:id_file_up_load])
    	array_email=params[:email].split(',')
    	array_email.each do |email|
    		@file_share =FileShare.new
    	    user = User.find_by_email(email)
    	    if !user.nil?
                if current_user!=user
                    @file_share.file_up_load_id=file_up_load.id
    	            @file_share.user_id = user.id
                    if @file_share.save
               	        UserMailer.send_email_notify_sharefile(user,file_up_load,@file_share).deliver
                        flash[:sucess]="You has shared to "+user.name+" a item."
                    else
        	            flash[:error]="Sorry,Share erors"
                    end
                else
                    flash[:notify]="Sorry,You shuold not to share a file to yourself."
                end    
            end
        end    
        redirect_to  file_up_load_path(file_up_load.id)
    end

    def download_file_shared
        @file_share=FileShare.find(params[:id])
        send_file @file_share.file_up_load.attach.path, :type => @file_share.file_up_load.attach_content_type
    end

    def correct_user_for_show_file_shared
        @user_shared_file=FileShare.find_by_id(params[:id]).user
        if current_user.id.to_s!=@user_shared_file.id.to_s
            redirect_to current_user, notice: "You not permission"
        end
    end  

end
