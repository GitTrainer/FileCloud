#class FilestreamsController < ApplicationController
# def index
#	@folder = Folder.find(params[:folder_id])
#	@fileupload=Filestream.new
# end
#
# def new
#	@folder = Folder.find(params[:folder_id])
#	@fileupload=Filestream.new
# end

# def create
#    @fileupload=Filestream.new(params[:filestream])
#      if @fileupload.save
#         redirect_to folder_path(@fileupload.folder_id)
#      else
#         render :action=>'new'
#      end
# end
#
# def download
#    @fileupload = Filestream.find(params[:id])
#      if @fileupload.attach_content_type == "image/*"
#        send_file @fileupload.attach.path, :type =>           	@fileupload.attach_content_type,:disposition=>'inline'
#      else
#        send_file @fileupload.attach.path, :type => @fileupload.attach_content_type
#      end
# end
#
# def destroy
#    @fileupload = Filestream.find(params[:id])
#    @folder_id = @fileupload.folder_id
#    @fileupload.destroy
#    redirect_to folder_path(@fileupload.folder_id)
# end
#end



class FilestreamsController < ApplicationController
  # GET /uploads
  # GET /uploads.json
  def index
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
    @upload = Filestream.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @upload }
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

  # GET /uploads/1/edit
  def edit
    @upload = Filestream.find(params[:id])
  end

  # POST /uploads
  # POST /uploads.json
  def create
    @folder = Folder.all
    @folder_id = params[:filestream][:folder_id]
    @uploads = Filestream.where(:folder_id => params[:filestream][:folder_id])
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

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload = Filestream.find(params[:id])
    @upload.destroy

    redirect_to folder_path(@upload.folder_id)
  end

   def download
    @fileupload = Filestream.find(params[:id])
      if @fileupload.attach_content_type == "image/*"
        send_file @fileupload.attach.path, :type =>           	@fileupload.attach_content_type,:disposition=>'inline'
      else
        send_file @fileupload.attach.path, :type => @fileupload.attach_content_type
      end
 end



end
