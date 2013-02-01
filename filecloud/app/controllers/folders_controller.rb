class FoldersController < ApplicationController
 
  before_filter :signed_in_user,only:[:new]
  before_filter :correct_user_folder,only:[:show,:edit,:destroy,:update]
  
  def index
  	 @folders=current_user.folders
  end

  def show
  	@folder=Folder.find(params[:id])
    @files=@folder.file_up_loads.paginate(:page => params[:page],:per_page =>1)
    respond_to do |format|
      format.html
      format.js {render js: @files }
    end
  end
  
  def new
  	@folder=Folder.new
  	@categorys=Category.all
  end

  def create
  	@folder=Folder.new(params[:folder])
    if @folder.save
    	 redirect_to folders_path
    else
        @categorys=Category.all
        render :action=>'new' 
    end    
  end

  def edit
  	@folder=Folder.find(params[:id])
  	@categorys=Category.all
  end

  def update
    @folder=Folder.find(params[:id])
    if @folder.update_attributes(params[:folder])
    	redirect_to :action=>'show'
    else
    	@categorys=Category.all
    	render :action=>'edit'
   end
  end

  def destroy
    Folder.find(params[:id]).destroy
    redirect_to folders_path
  end
  
  def correct_user_folder
      @user=Folder.find(params[:id]).user
      redirect_to(root_path) unless current_user?(@user)
    end
  end
