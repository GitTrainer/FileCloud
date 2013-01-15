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
    @fileupload=Filestream.new(params[:filestream])
      if @fileupload.save
         redirect_to folder_path(@fileupload.folder_id)
      else
         render :action=>'new' 
      end  
 end
 
 def download
    @fileupload = Filestream.find(params[:id])
      if @fileupload.attach_content_type == "image/*"
        send_file @fileupload.attach.path, :type =>           	@fileupload.attach_content_type,:disposition=>'inline'
      else
        send_file @fileupload.attach.path, :type => @fileupload.attach_content_type
      end
 end
 
 def destroy
    @fileupload = Filestream.find(params[:id])
    @folder_id = @fileupload.folder_id
    @fileupload.destroy
    redirect_to folder_path(@fileupload.folder_id)
 end
end
