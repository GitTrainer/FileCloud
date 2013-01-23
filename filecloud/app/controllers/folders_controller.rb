class FoldersController < ApplicationController
  
  def index
  	 @folders=Folder.all
  end

  def show
  	@folder=Folder.find(params[:id])
  end

  def new
  	@folder=Folder.new
  	@categorys=Category.all
  end

  def create

  	@folder=Folder.new(params[:folder])
    if @folder.save
    	 redirect_to current_user
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
    redirect_to current_user 
end
end
