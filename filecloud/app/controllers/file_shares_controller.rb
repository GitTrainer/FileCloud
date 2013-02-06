class FileSharesController < ApplicationController


 def new
 end

def create
	activated_ids = params[:activated].collect {|id| id.to_i} if params[:activated]
	#binding.pry
	if !activated_ids.nil?
	  activated_ids.each do |id|
	  #binding.pry
        FileShare.find_by_user_id(id).destroy
      #binding.pry
	  end
    end
	file_up_load =FileUpLoad.find_by_id(params[:id_file_up_load])
	array_email=params[:email].split(',')
	
	array_email.each do |email|

		@file_share =FileShare.new
	    user = User.find_by_email(email)
	    if !user.nil?
           @file_share.file_up_load_id=file_up_load.id
	       @file_share.user_id = user.id
         
            if @file_share.save
           	     UserMailer.send_email_notify_sharefile(user,file_up_load).deliver
                 flash[:sucess]="Share success"
              
            else
    	      flash[:error]="Sorry,Share erors"
            end
        end
    end    
    redirect_to  file_up_load_path(file_up_load.id)
end

end