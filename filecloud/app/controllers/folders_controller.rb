class FoldersController < ApplicationController
  # GET /folders
  # GET /folders.json

  def index
     # binding.pry
    if current_user.has_role? :admin
      @folders = Folder.all
    else

    @folders = Folder.where(:user_id => current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @folders }
    end
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
    # binding.pry
    @folder = Folder.new

    respond_to do |format|
      format.html  # new.html.erb
      format.json { render json: @folder }
    end
  end

  # GET /folders/1/edit
  def edit
    # binding.pry
    @search = Folder.search(params[:search]).where(params[:user_id])
    # @folders = @search.paginate(:per_page => 10, :page => params[:page])
    @folders = Folder.where(:user_id => current_user.id)

    @folder = Folder.find(params[:id])
    respond_to do |format|
      format.html { render action: "index"}
    end
  end

def create
   # binding.pry
   # params[:user_id]= current_user.id
    @folder = Folder.new(params[:folder])
    # @folder = Folder.where(:user_id=>current_user.id)
    

  
    respond_to do |format|
      if @folder.save  
        format.html { redirect_to folders_path, notice: 'Folder was successfully created.' }
        format.json { render json: @folder, status: :created, location: @folder }
      else
        
        format.html { redirect_to folders_path, notice: 'Category errors' }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /folders/1
  # PUT /folders/1.json
  def update
    # binding.pry
    @folder = Folder.find(params[:id])
    

    respond_to do |format|
      if @folder.update_attributes(params[:folder])
        format.html { redirect_to folders_path, notice: 'Folder was successfully updated.' }
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
