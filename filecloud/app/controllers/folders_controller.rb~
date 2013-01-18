class FoldersController < ApplicationController
def index
	@folders = Folder.all
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
	  @folders = Folder.all
 respond_to do |format|
       if @new_folder.save

			 	 @new_folder = nil
			 	format.html { render action: "index"}
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
	@folders = Folder.all
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
	@folders = Folder.all
       respond_to do |format|
         if @new_folder.update_attributes(params[:folder])
		  @new_folder = nil
         format.html { redirect_to "/folders" }
          format.js { render js: @new_folder }

        else
             format.html {  render action: "index"}
             format.js {render js: @new_folder.errors, status: :unprocessable_entity}
             format.js {render js: @folders }
        end
         end
end

def destroy
	@folder = Folder.find(params[:id])
	@folder.destroy
	respond_to do |format|
             format.html { redirect_to "/folders"}
         end
end
end
