class FilestreamsController < ApplicationController
  # GET /uploads
  # GET /uploads.json
  before_filter :signed_in_user
  before_filter :correct_user,   only: [:index]

  def index
    @folder_id = params[:folder_id]
    @uploads = Filestream.where(:folder_id => params[:folder_id])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @uploads.map{|upload| upload.to_jq_upload } }
      format.json {render json: @uploads}
    end
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
    @folder_id = Filestream.find(params[:id]).folder_id
    @user_id= Folder.find(@folder_id).user_id
    respond_to do |format|
	    if current_user.id.to_s == @user_id.to_s || Foldersharing.where(:shared_user_id => current_user.id, :folder_id => @folder_id).exists? || Filesharing.where(:shared_user_id => current_user.id, :file_id => params[:id]).exists?
  	    @upload = Filestream.find(params[:id])
        format.html # show.html.erb
        format.json { render json: @upload }
   	  else
        format.html { redirect_to root_path }
      end
    end
  end

  # GET /uploads/new
  # GET /uploads/new.json
  def new

    @upload = Filestream.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @upload }
    end
  end


  # POST /uploads
  # POST /uploads.json
  def create
    @folder_id = params[:filestream][:folder_id]
    @upload = Filestream.new(params[:filestream])
    @upload.folder_id = params[:filestream][:folder_id]
    respond_to do |format|
      if @upload.save
        format.html {
          render :json => [@upload.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: [@upload.to_jq_upload].to_json, status: :created, location: @upload }
      else
        format.html { render action: "index" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  def download
     @fileupload = Filestream.find(params[:id])
     download_count=@fileupload.download_count
     @fileupload.update_attribute(:download_count, download_count+1) 
     if @fileupload.attach_content_type == "image/*"
       send_file @fileupload.attach.path, :type =>
       @fileupload.attach_content_type,:disposition=>'inline'
     else
       send_file @fileupload.attach.path, :type => @fileupload.attach_content_type
     end
     # redirect_to "/folders/"+@fileupload.folder_id.to_s+"&?user_id="+current_user.id.to_s
  end

	 def delete_from_folder

	 	 @upload = Filestream.find(params[:id])
		 @upload.destroy
		 redirect_to ("/folders/"+@upload.folder_id.to_s+"&?user_id="+current_user.id.to_s)
	 end

	 def destroy
   	 @delete_file = Filestream.find(params[:id])
   	 @folder_id = @delete_file.folder_id
     @delete_file.destroy
     respond_to do |format|
       format.html { redirect_to "/filestreams/?folder_id=" + folder_id.to_s }
       format.json { head :no_content }
     end
   end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
			if Folder.find(params[:folder_id]).user_id.to_s != current_user.id.to_s
				flash[:notice] = "You do not have permission to do this"
				redirect_to root_path
      end
    end

end
