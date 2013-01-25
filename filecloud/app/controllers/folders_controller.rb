class FoldersController < ApplicationController
  # GET /folders
  # GET /folders.json

#upaload file
def uploadFile
  
  post=DataFile.save(params[:upaload])
  render :text => "File has been uploaded successfully!"
end

  def index
    @folders = Folder.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @folders }
    end
  end

  # GET /folders/1
  # GET /folders/1.json
  def show
    @folder = Folder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @folder }
    end
  end

  # GET /folders/new
  # GET /folders/new.json
  def new
    @folder = Folder.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @folder }
    end
  end

  # GET /folders/1/edit
  def edit
    @folder = Folder.find(params[:id])
  end

  # POST /folders
  # POST /folders.json

  # def create
  #   @folder = Folder.new(params[:folder])

  #   respond_to do |format|
  #     if @folder.save
  #       format.html { redirect_to @folder, notice: 'Folder was successfully created.' }
  #       format.json { render json: @folder, status: :created, location: @folder }
  #     else
  #       format.html { render action: "new" }
  #       format.json { render json: @folder.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

def create
  #binding.pry
    @folder = Folder.new(params[:folder])
        pic=params[:folder][:description]
    if (!pic.nil?)
      # binding.pry
    @folder.description = pic.original_filename
    path = "#{Rails.root}/app/assets/images/#{@folder.category_id}_#{pic.original_filename}"
    FileUtils.copy(pic.tempfile, path)
        end
    respond_to do |format|
       if @folder.save
        if (!pic.nil?)
    params[:folder][:description] ="#{@folder.category_id}_#{pic.original_filename}"
    format.html { redirect_to @folder, notice: 'Folder was successfully created.' }
        format.json { render json: @folder, status: :created, location: @folder }
    else
    params[:folder][:description] =""
    format.html { render action: "new" }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
        end
    end
    end
  end

  # PUT /folders/1
  # PUT /folders/1.json
  def update
    # binding.pry
    @folder = Folder.find(params[:id])
    pic=params[:folder][:description]
    if(!pic.nil?)
      path =  "#{Rails.root}/app/assets/images/#{@folder.category_id}_#{pic.original_filename}"
        FileUtils.copy(pic.tempfile, path)
        params[:folder][:description] = "#{@folder.category_id}_#{pic.original_filename}"
    end

    respond_to do |format|
      if @folder.update_attributes(params[:folder])
        format.html { redirect_to @folder, notice: 'Folder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1
  # DELETE /folders/1.json
  def destroy
    @folder = Folder.find(params[:id])
    @folder.destroy

    respond_to do |format|
      format.html { redirect_to folders_path }
      format.json { head :no_content }
    end
  end
end
