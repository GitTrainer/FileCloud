require 'zip/zip'
require 'zip/zipfilesystem'
require 'open-uri'

class FoldersController < ApplicationController
  include FoldersHelper
  helper_method :sort_column, :sort_direction
  before_filter :signed_in_user,only:[:new,:index]
  before_filter :correct_user_folder,only:[:show,:edit,:destroy,:update,:down]
  
  def index
  	 @folders=current_user.folders
  end

  def show
  	@folder=Folder.find(params[:id])
    @subFolders=Folder.where(:parentId => @folder.id)
    @files = @folder.file_up_loads.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
  end
  
  def new
    @folder=Folder.new
    @parentId=params[:Fparent]
    @parentLevel=params[:parentLevel]
   
    if @parentLevel
      @newLevel=@parentLevel.to_i+1
    end

    if !@parentId 
      @categorys=Category.all
    else
      folder=Folder.find(@parentId)
      @categorys=Category.find(folder.category_id)
    end
  end

  def create
  	@folder=Folder.new(params[:folder])
    if @folder.save
    	redirect_to folder_path(@folder) ,:notice=> "Sucessful created!"
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
    @current_folder=Folder.find(params[:id])
    if @current_folder.user.id.to_s!=current_user.id.to_s
      redirect_to current_user
    end
    Folder.find(params[:id]).destroy
    redirect_to folders_path
  end
    
  def correct_user_folder
    @user=Folder.find(params[:id]).user
    redirect_to(root_path) unless current_user?(@user)
  end

  def down
    @folder=Folder.find(params[:id])
    downloadSubFolder(@folder)
    path=Rails.root.join(@folder.name).to_s
    archive = path +'.zip'
    
    Zip::ZipFile.open(archive, 'w') do |zipfile|
      Dir["#{path}/**/**"].reject{|f|f==archive}.each do |file|
        zipfile.add(file.sub(path+'/',''),file)
      end
    end
    send_file archive, :type => 'application/zip', :disposition => 'attachment', :filename => "#{@folder.name}.zip"
    FileUtils.rm archive, :force=>true
    #FileUtils.rm path, :force=>true
    FileUtils.rm_r(path, :force => true)
    Dir.chdir(Rails.root.to_s)
    $path=Rails.root.to_s
    $level=0
    
  end
  private

    def sort_column
      FileUpLoad.column_names.include?(params[:sort]) ? params[:sort] : "attach_file_name"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end