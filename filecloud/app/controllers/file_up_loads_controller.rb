class FileUpLoadsController < ApplicationController

before_filter :signed_in_user
before_filter :correct_user_for_download_file ,only: [:download,:show,:destroy]
before_filter :correct_user_folder_fileupload,only:[:new]

def index
	
end  

  def new
    @folder=Folder.find_by_id(params[:id])
  	@fileupload=FileUpLoad.new
    
  end

  def create

    @fileupload=FileUpLoad.new(params[:file_up_load])
    if @fileupload.save
      respond_to do |format|
        format.html { redirect_to folder_path(@fileupload.folder)}
        format.js { render json: [@fileupload.folder.to_json] }
      end
    else
      render :action=>'new' 
    end  
  end

	def show
    @fileupload=FileUpLoad.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    if @fileupload
      render 'show'
    else
      render 'shared/notify'
    end
	end

  def destroy
    @folder_id=FileUpLoad.find_by_id(params[:id]).folder_id
    FileUpLoad.find_by_id(params[:id]).destroy
    redirect_to :back,notice: "Successfull destroy"
  end

  def download
    @fileupload=FileUpLoad.find(params[:id])
    temp=@fileupload.count_download
    temp+=1
    @fileupload.update_attribute(:count_download,temp)
    if @fileupload.attach_content_type=="image/jpeg"
      send_file @fileupload.attach.path, :type => @fileupload.attach_content_type,:disposition=>'inline'
    else
      send_file @fileupload.attach.path, :type => @fileupload.attach_content_type
     end
  end
  
  def deletefiles
    if params[:file_ids]
      FileUpLoad.delete_all(["id in (?)",params[:file_ids]])
      redirect_to :back,notice: "Files Successfull destroyed"
    else
      redirect_to :back,notice: "You don't select file"
    end
  end

  def correct_user_folder_fileupload  
      @current_folder=Folder.find(params[:id])
     if @current_folder.user.id.to_s!=current_user.id.to_s
        redirect_to current_user
     end
  end
end
