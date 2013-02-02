class FileSharesController < ApplicationController
 def new
 end

def create
	
	file_up_load =FileUpLoad.find_by_id(params[:id_file_up_load])
	array_email=params[:email].split(',')
	
	array_email.each do |email|

		@file_share =FileShare.new
	    user = User.find_by_email(email)

	    @file_share.file_up_load_id=file_up_load.id
	    @file_share.user_id = user.id
         
           if @file_share.save
           	   
              flash[:sucess]="Share success"
              
           else
    	      flash[:error]="Sorry,Share erors"
            end
    end
    redirect_to  file_up_load_path(file_up_load.id)
end

end
