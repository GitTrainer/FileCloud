class UploadsController < ApplicationController
  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @uploads.map{|upload| upload.to_jq_upload } }
    end
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
    @upload = Upload.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @upload }
    end
  end

  # GET /uploads/new
  # GET /uploads/new.json
  def new
    @folder=Folder.find_by_id(params[:id])
    @upload = Upload.new

    
  end

  # GET /uploads/1/edit
  def edit
    @upload = Upload.find(params[:id])
  end

  # POST /uploads
  # POST /uploads.json
  def create

    @upload = Upload.new(params[:upload])

    respond_to do |format|
      if @upload.save
        # format.html {
        #   render :json => [@upload.to_jq_upload].to_json,

        #   :content_type => 'text/html',
        #   :layout => false
        # }
        # format.html {redirect_to folder_path }
     
        format.json { render json: [@upload.to_jq_upload].to_json, status: :created, location: @upload }
           format.html {redirect_to folder_path(@upload.folder) }
      else
        format.html { render action: "new" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /uploads/1
  # PUT /uploads/1.json
  def update
    @upload = Upload.find(params[:id])

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

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy

    respond_to do |format|
      format.html { redirect_to folder_path(@upload.folder) }
      format.json { head :no_content }
    end
  end


  def download
      # binding.pry
      @upload=Upload.find(params[:id])
      if @upload.upload_content_type=="image/*"
        send_file @upload.upload.path, :type=>@upload.upload_content_type,:disposition=>'inline'
      else
        send_file @upload.upload.path, :type=>@upload.upload_content_type
      end
    end
end
