require 'zip/zip'
require 'zip/zipfilesystem'
require 'open-uri'

class FoldersController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :signed_in_user,only:[:new]
  before_filter :correct_user_folder,only:[:show,:edit,:destroy,:update]
  
  def index
  	 @folders=current_user.folders
  end

  def show
  	@folder=Folder.find(params[:id])
    @files = @folder.file_up_loads.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
    # respond_to do |format|
    #     format.html # show.html.erb
    #     format.json { render json: @folder }
    #   end  
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
    t = Tempfile.new("#{@folder.name}-#{Time.now}")
    Zip::ZipOutputStream.open(t.path) do |zos|
      @folder.file_up_loads.each do |file|
        zos.put_next_entry(file.attach_file_name)
        zos.print IO.read(file.attach.path)
      end
    end
    send_file t.path, :type => 'application/zip', :disposition => 'attachment', :filename => "#{@folder.name}.zip"
    t.close
  end
  private
    def sort_column
        FileUpLoad.column_names.include?(params[:sort]) ? params[:sort] : "attach_file_name"
    end
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end