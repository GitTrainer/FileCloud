class FilestreamsController < ApplicationController
require 'zip/zip'
require 'zip/zipfilesystem'
before_filter :signed_in_user, only: [:index, :destroy, :create, :multiple_delete]
before_filter :correct_user,   only: [:index]

  def index
    @folder_id = params[:folder_id]
    @uploads = Filestream.where(:folder_id => params[:folder_id])
    respond_to do |format|
      format.html # index.html
      format.json { render json: @uploads.map{|upload| upload.to_jq_upload } }
      format.json {render json: @uploads}
    end
  end

	def indexpublic
    @filestreams=Filestream.where(:status =>true)
    respond_to do |format|
  	  format.html {render :action => "filepublic"}
  	  format.json { render json: @filestreams }
    end
  end

  def show
    @folder = Folder.find(Filestream.find(params[:id]).folder_id)
    @user_id = @folder.user_id
    @upload = Filestream.find(params[:id])
    @flagPass = false
    @flagSigned = false
    @flagNotSigned = false
    @flagWrongPass = false
    @flagSignedStatus = false
    respond_to do |format|
			if signed_in?
	   	  if current_user.id.to_s == @user_id.to_s || Foldersharing.where(:shared_user_id => current_user.id, :folder_id => @folder.id).exists? || Filesharing.where(:shared_user_id => current_user.id, :file_id => params[:id]).exists?
	   	  	@flagSigned = true
        	format.html
   	  	else
   	  		if @upload.status == true
   	  			@flagSignedStatus = true
   	  			if @upload.password_protect == params[:password]
  	      		@flagPass = true
	          	format.html
	          else
	        		@flagWrongPass = true
							format.html
	          end
	        else
	        	format.html { redirect_to root_path}
	        end
      	end
      else
      	if @upload.password_protect == params[:password]
      		@flagNotSigned = true
      		@flagPass = true
    			format.html
    		else
    			@flagNotSigned = true
    			@flagWrongPass = true
					format.html
				end
    	end
    end
  end

  def new
    @upload = Filestream.new
    respond_to do |format|
      format.html
      format.json { render json: @upload }
    end
  end

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

  def accept
    @uploads = Filestream.find(params[:id])
    if params[:status]=="true"
      temp="false"
    else
      temp="true"
    end
    @uploads.status=temp
    @uploads.save!
    redirect_to ("/folders/"+@uploads.folder_id.to_s)
    end

  def password_protect
    @filespass = Filestream.find(params[:file_id])
    @filespass[:password_protect]=nil
    if params[:commit] == 'Save'
      @filespass.update_attributes :password_protect=>params[:password_protect]
    end
    @filespass.save!
    redirect_to ("/folders/"+@filespass.folder_id.to_s)
  end

  def create_unlocked
    redirect_to ("/filestreams/"+params[:file_id])
  end

  def download
    @fileupload = Filestream.find(params[:file_id])
    download_count=@fileupload.download_count
    password = @fileupload.password_protect
    if params[:password_protect] == password
		  @fileupload.update_attribute(:download_count, download_count+1)
		  if @fileupload.attach_content_type == "image/*"
		    send_file @fileupload.attach.path, :type =>
		    @fileupload.attach_content_type,:disposition=>'inline'
		  else
		    send_file @fileupload.attach.path, :type => @fileupload.attach_content_type
		  end
    else
			flash[:error] = "Invalid password"
			redirect_to :back
    end
  end

  def download_public_file
    @fileupload = Filestream.find(params[:id])
    download_count=@fileupload.download_count
    @fileupload.update_attribute(:download_count, download_count+1)
    if @fileupload.attach_content_type == "image/*"
      send_file @fileupload.attach.path, :type =>
      @fileupload.attach_content_type,:disposition=>'inline'
    else
      send_file @fileupload.attach.path, :type => @fileupload.attach_content_type
    end
  end

	 def delete_from_folder
	 	 @upload = Filestream.find(params[:id])
		 @upload.destroy
		 redirect_to ("/folders/"+@upload.folder_id.to_s)
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

   def multiple_delete
   	 check_ids = params[:check]
   	 if check_ids.nil?
   	 	redirect_to ("/folders/" + params[:fID])
   	 else
    	 if params[:commit].to_s == "Delete"
				 check_ids.each do |check|
				   del = Filestream.find(check)
					 del.destroy
				 end
				 redirect_to ("/folders/" + params[:fID])
			 else
				 @files = check_ids
  		   t = Tempfile.new('tmp-zip-' + request.remote_ip)
    		 Zip::ZipOutputStream.open(t.path) do |zos|
				   @files.each do |file|
				  	 f = Filestream.find(file)
				  	 download_count= f.download_count
	           f.update_attribute(:download_count, download_count+1)
		  		   zos.put_next_entry(f.attach_file_name)
		  		   zos.print IO.read(f.attach.path)
		 		   end
  			 end
  		   send_file t.path, :type => "application/zip", :filename => "FileIn-#{Folder.find(params[:fID]).name}-#{Time.now}.zip"
  		   t.close
		   end
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
