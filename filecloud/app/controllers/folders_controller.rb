class FoldersController < ApplicationController
	include FoldersHelper
	require 'zip/zip'
	require 'zip/zipfilesystem'
	require 'open-uri'

  before_filter :signed_in_user , only: [:index, :edit, :update, :destroy, :create, :create_child]
  helper_method :sort_column, :sort_direction

   def index
		@search_folder = Folder.where(:user_id => current_user).search(params[:search])
		if ( @new_folder.nil?)
			@new_folder = Folder.new
		end
   	respond_to do |format|
		  format.html { render action: "index"}
		  format.js {render js: @new_folder }
      format.js {render js: @search_folder }
    end
	end

	def new
		if ( @new_folder.nil?)
			@new_folder = Folder.new
		end
		@folders = Folder.where(:user_id => current_user.id)
   	respond_to do |format|
		  format.html
		end
	end

	def indexpublic
		@folders = Folder.where(:status =>true)
		respond_to do |format|
	  	format.html { render action: "public"}
	 	  format.js {render js: @folders}
		end
	end

	def create
		@new_folder = Folder.new(params[:folder])
		@new_folder.level = 1
		respond_to do |format|
		  if @new_folder.save
			  @new_folder = nil
  			@folders = Folder.where(:user_id => current_user)
				format.html { redirect_to "/folders/new"}
		    format.js {render js: @new_folder }
		    format.js {render js: @folders }
		  else
			  @folders = Folder.where(:user_id => current_user)
				format.html { redirect_to "/folders/new" }
			  flash[:error] = "Name already taken."
		    format.js {render js: @folders }
		  end
		end
	end

	 def accept
		 @search_folder = Folder.find(params[:id])
     if params[:status]=="true"
       temp="false"
     else
       temp="true"
     end
     @search_folder.status=temp
     @search_folder.save!
     redirect_to folders_path
   end

	def edit
		@new_folder = Folder.find(params[:id])
		@folders = Folder.where(:user_id => current_user)
	end

	def show
		@folder = Folder.find(params[:id])
		@sort_file=Filestream.order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
		@uploads = @sort_file.where(:folder_id => params[:id]).search(params[:search])
		@foldersharings = Foldersharing.all
		@id = params[:id].to_i
		if Folder.where(:status =>true, :id =>@id).exists? || Folder.where(:user_id => current_user.id, :id => @id).exists?
			@folder = Folder.find(@id)
			render :action=> 'show'
		else
			if isParent
				@folder = Folder.find(params[:id])
		 	else
		 		redirect_to root_path
			end
		end
	end

	def update
		@new_folder = Folder.find(params[:id])
		@folders = Folder.where(:user_id => current_user)
		respond_to do |format|
			if @new_folder.update_attributes(params[:folder])
				@new_folder = nil
				@search_folder = Folder.where(:user_id => current_user).search(params[:search])
		    format.html { redirect_to "/folders/new"}
		  else
		    format.html { redirect_to ("/folders/" + params[:id] + "/edit") }
				flash[:error] = "Please input required fields"
		  end
		end
	end

	def destroy
		@folder = Folder.find(params[:id])
		getAllFolderByList(@folder)
		@foldersharings = Foldersharing.all
		$list.each do |f|
			Folder.find(f.id).destroy
		end
		respond_to do |format|
		  format.html { redirect_to "/folders/new"}
    end
	end

	def folder_download
		@folder=Folder.find(params[:id])
    downloadSubFolder(@folder)
    path = Rails.root.join(@folder.name).to_s
    archive = path +'.zip'
    Zip::ZipFile.open(archive, 'w') do |zipfile|
      Dir["#{path}/**/**"].reject{|f|f==archive}.each do |file|
        zipfile.add(file.sub(path+'/',''),file)
      end
    end
    send_file archive, :type => 'application/zip', :disposition => 'attachment', :filename => "#{@folder.name}.zip"
    FileUtils.rm archive, :force=>true
    FileUtils.rm_r(path, :force => true)
    Dir.chdir(Rails.root.to_s)
    $path=Rails.root.to_s
    $level=0
	end

	def create_child
		@child = Folder.new
		@child.name = params[:name]
		@child.description = params[:description]
		@child.parentID = params[:parentID]
		@child.category_id = params[:category_id]
		@child.user_id = params[:user_id]
		@child.level = Folder.find(params[:parentID]).level.to_i + 1
		if @child.save
			@child = nil
			redirect_to ("/folders/"+ params[:parentID]+"/folder_child")
		else
			redirect_to ("/folders/"+ params[:parentID]+"/folder_child")
			flash[:error] = "Please fill all fields correctly!"
		end
	end

  private

  def isParent 											#finding the parent and check it is share or not.
		temp = true
		folder_id = params[:id]
		begin
			x = Folder.find(folder_id).parentID
			if x.nil?
				if Foldersharing.where(:shared_user_id => current_user.id, :folder_id => folder_id).exists?
					return true
				else
					return false
				end
			else
			#If parent is shared, return true
				if Foldersharing.where(:shared_user_id => current_user.id, :folder_id => folder_id).exists?
					return true
				else
				# Finding last parent is shared or not.
					folder_id = Folder.find(folder_id).parentID
					temp = false
				end
			end
		end while(temp = true, x = nil)
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

	def sort_column
	    Filestream.column_names.include?(params[:sort]) ? params[:sort] : "attach_file_name"
	end

	def sort_direction
	    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	end
end
