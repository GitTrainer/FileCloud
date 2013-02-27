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
        format.html {
          render :json => [@fileupload.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: [@fileupload.to_jq_upload].to_json, status: :created, location: @fileupload }
      end
    else
      render :action=>'new' 
    end  
  end

	def show
    @fileupload=FileUpLoad.find(params[:id])
    # rescue ActiveRecord::RecordNotFound
    if @fileupload
      # render 'show'
      respond_to do |format|
        format.html 
        format.js { render json: @fileupload.to_json }
      end
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
      if params[:delFiles]
        FileUpLoad.delete_all(["id in (?)",params[:file_ids]])
        redirect_to :back,notice: "Files Successfull destroyed"
      else
        t = Tempfile.new("mulFiles-#{Time.now}")
        Zip::ZipOutputStream.open(t.path) do |zos|
            params[:file_ids].each do |id|
            f=FileUpLoad.find(id)
            zos.put_next_entry(f.attach_file_name)
            zos.print IO.read(f.attach.path)
          end
        end
        send_file t.path, :type => 'application/zip', :disposition => 'attachment', :filename => "mulFiles.zip"
        t.close
      end
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
