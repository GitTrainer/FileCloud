class FoldersController < ApplicationController
  before_filter :signed_in_user
def index
	@folders = Folder.where(:user_id => current_user)
	if ( @new_folder.nil?)
	  @new_folder = Folder.new
	end
          respond_to do |format|
             format.html { render action: "index"}
              format.js {render js: @new_folder }
               format.js {render js:  @folders }
             end
end
def new
 @new_folder = Folder.new
end

def create
	 @new_folder = Folder.new(params[:folder])
   # binding.pry
	@folders = Folder.where(:user_id => current_user)
 respond_to do |format|
       if @new_folder.save

			 	 @new_folder = nil
			 	format.html { redirect_to "/folders/?user_id=" + params[:folder][:user_id]}
              format.js {render js: @new_folder }
              format.js {render js: @folders }
       else

         format.html { render action: "index"}
         format.js {render js: @new_folder.errors, status: :unprocessable_entity}
         format.js {render js: @folders }
         end
       end
end

def edit
	@folders = Folder.where(:user_id => current_user)
    @new_folder = Folder.find(params[:id])
    respond_to do |format|
             format.html { render action: "index"}
             format.js {render js: @new_folder}
             format.js {render js: @folders }
             end
end

def show
	@folder = Folder.find(params[:id])
          respond_to do |format|
             format.html { render action: "show"}
              format.js {render js: @folder }
             end
end

def update
	@new_folder = Folder.find(params[:id])
	@folders = Folder.where(:user_id => current_user)
       respond_to do |format|
         if @new_folder.update_attributes(params[:folder])
		  @new_folder = nil
         format.html { redirect_to "/folders/?user_id=" + params[:folder][:user_id]}
          format.js { render js: @new_folder }

        else
             format.html {  render action: "index"}
             format.js {render js: @new_folder.errors, status: :unprocessable_entity}
             format.js {render js: @folders }
        end
         end
end

def destroy
  @user_id = Folder.find(params[:id]).user_id
	@folder = Folder.find(params[:id])
	@folder.destroy
	respond_to do |format|
             format.html { redirect_to "/folders/?user_id=" + @user_id.to_s }
         end
end

def share

end
	@users = User.all

end
