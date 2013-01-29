class FoldersController < ApplicationController
  before_filter :authenticate_user!

# GET /folders
# GET /folders.json

  def index
   # @folders = Folder.all
    @search =Folder.search(params[:search])  
    @folders = @search.paginate(:per_page => 10, :page => params[:page])

  respond_to do |format|
    format.html # index.html.erb
    format.json { render json: @folders }
  end
end

  # GET /folders/1
  # GET /folders/1.json
  def show
    @folder = Folder.find(params[:id])
    @search=Folder.search(params[:search])
    @folders=@search.paginate(:per_page=>10,:page=>params[:page])

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
    # @folder = Folder.find(params[:id])
    @search = Folder.search(params[:search])
    @folders = @search.paginate(:per_page => 2, :page => params[:page])

    @folder = Folder.find(params[:id])
    respond_to do |format|
      format.html { render action: "index"}
    end
  end

def create
  # binding.pry
    @folder = Folder.new(params[:folder])
  
    respond_to do |format|
      if @folder.save  
        format.html { redirect_to folders_path, notice: 'Folder was successfully created.' }
        format.json { render json: @folder, status: :created, location: @folder }
      else
        
        format.html { redirect_to folders_path, notice: 'Folder errors.' }
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
