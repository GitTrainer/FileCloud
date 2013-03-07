class SessionsController < ApplicationController

  def new
  end

  def create
    binding.pry
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.status==true
        sign_in user
        redirect_to user
      else
        flash[:error] = 'Please active in your mail' # Not quite right!
        render 'new'
      end
    else
      flash[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

    def create_unlocked
      binding.pry
    @filestream=Filestream.find_by_id(params[:file_id])
    if @filestream && @filestream.authenticate(params[:password_protect])
      redirect_to '/filestreams/'+@filestream.to_s
    else
      flash.now[ :error]='password protect unmark'
      redirect_to ("/folders/"+@filestream.folder_id.to_s)
    end
    
  end




  def destroy
    sign_out
    redirect_to root_url
  end
end
