class FilestreamsController < ApplicationController
def index
	@folder = Folder.find(params[:folder_id])
	@fileupload=Filestream.new
end
def new
	@folder = Folder.find(params[:folder_id])
	@fileupload=Filestream.new
end



def create
#	@folder_id = params[:filestream][:folder_id]
#	@folder = Folder.find(params[:filestream][:folder_id])
#	@new_file = Filestream.new
#	@new_file.folder_id = params[:filestream][:folder_id]
#		file = params[:filestream][:filename]
#        if (!file.nil?)
#		@filename = file.original_filename
#		path = "#{Rails.root}/app/assets/images/#{file.original_filename}"
#		FileUtils.copy(file.tempfile, path)
#        end

#	if Filestream.create!(:filename => @filename, :folder_id => @folder_id)
#	   if (!file.nil?)
#		  params[:filestream][:filename] ="#{file.original_filename}"
#	   else
#		  params[:filestream][:filename] =""
#       end
#	 	 @new_file = nil	
#		 redirect_to ("/folders/" + @folder_id.to_s)
#       else           
#         respond_to do |format|
#         format.html { render action: "index"}
#         format.js {render js: @new_file.errors, status: :unprocessable_entity}
#         format.js {render js: @folder }
#         end
#       end
@fileupload=Filestream.new(params[:filestream])
    if @fileupload.save
       redirect_to folder_path(@fileupload.folder_id)
    else
        render :action=>'new' 
    end  
end
 def download
      @fileupload=FileUpLoad.find(params[:id])
      if @fileupload.attach_content_type == "image/*"
       send_file @fileupload.attach.path, :type => @fileupload.attach_content_type,:disposition=>'inline'
     else
      send_file @fileupload.attach.path, :type => @fileupload.attach_content_type
     end
    end
end
