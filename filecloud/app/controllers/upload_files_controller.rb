class UploadFilesController < ApplicationController
  # GET /upload_files
  # GET /upload_files.json

def index
  
end  

  def new
    @folder=Folder.find_by_id(params[:id])
    @fileupload=UploadFile.new
  end

  def create
   # binding.pry
    @fileupload=UploadFile.new(params[:upload_file])
    if @fileupload.save
       redirect_to folder_path(@fileupload.folder_id)
    else
   
        render :action=>'new' 
    end  
    end

    def show
    end

    def destroy
      
   @upload = UploadFile.find(params[:id])
    @upload.destroy

    redirect_to folder_path(@upload.folder_id)

      
    
    end

    def download
      # binding.pry
      @fileupload=UploadFile.find(params[:id])
      if @fileupload.attach_content_type=="image/*"
        send_file @fileupload.attach.path, :type=>@fileupload.attach_content_type,:disposition=>'inline'
      else
        send_file @fileupload.attach.path, :type=>@fileupload.attach_content_type
      end
    end
end