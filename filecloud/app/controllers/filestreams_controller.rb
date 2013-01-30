class FilestreamsController < ApplicationController
  # GET /uploads
  # GET /uploads.json
  before_filter :signed_in_user
  before_filter :correct_user,   only: [:index]

  def index
    @folder = Folder.paginate(page: params[ :page], :per_page => 3)
    @filestream = Filestream.paginate(page: params[ :page], :per_page => 3)
    @folder = Folder.all
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

    @filestream = Filestream.paginate(page: params[ :page], :per_page => 3)
    @upload = Filestream.find(params[:id])
   
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @upload }
    end
  end

  # GET /uploads/new
  # GET /uploads/new.json
  def new
     @folder = Folder.paginate(page: params[ :page], :per_page => 3)
    @filestream = Filestream.paginate(page: params[ :page], :per_page => 3)
    @upload = Filestream.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @upload }
    end
  end

  # GET /uploads/1/edit
  def edit
    # @upload = Filestream.paginate(page: params[ :page], :per_page => 3)
    @upload = Filestream.find(params[:id])
  end

  # POST /uploads
  # POST /uploads.json
  def create
     @folder = Folder.paginate(page: params[ :page], :per_page => 3)
    @filestream = Filestream.paginate(page: params[ :page], :per_page => 3)
    @folder = Folder.all
    @folder_id = params[:filestream][:folder_id]
    @uploads = Filestream.where(:folder_id => params[:filestream][:folder_id])
     @folder = Folder.paginate(page: params[ :page], :per_page => 3)
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
        format.json { render json: @uploads }

      else
        format.html { render action: "new" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /uploads/1
  # PUT /uploads/1.json
  def update
    # @upload = Filestream.paginate(page: params[ :page], :per_page => 3)
    @upload = Filestream.find(params[:id])

    respond_to do |format|
      if @upload.update_attributes(params[:upload])
        format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

   def download
    @fileupload = Filestream.find(params[:id])

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
