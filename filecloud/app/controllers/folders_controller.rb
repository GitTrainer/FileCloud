class FoldersController < ApplicationController
  before_filter :signed_in_user

  helper_method :sort_column, :sort_direction

   def index
		@foldersharings = Foldersharing.all
		@search_folder = Folder.where(:user_id => current_user).search(params[:search])
		# @folder_paginate=@search_folder.paginate(:per_page => 5, :page => params[:page])
		if ( @new_folder.nil?)
			@new_folder = Folder.new
		end

     	respond_to do |format|
	         format.html { render action: "index"}
	         format.js {render js: @foldersharings}
	         format.js {render js: @new_folder }
	         format.js {render js: @search_folder }
      	end

	end

	def new
  	@foldersharings = Foldersharing.all
	  @new_folder = Folder.new
	end

	def create
    @foldersharings = Foldersharing.all
		@foldersharings = Foldersharing.all
		@new_folder = Folder.new(params[:folder])
		respond_to do |format|
		  if @new_folder.save
			  @new_folder = nil
  			@search_folder = Folder.where(:user_id => current_user).search(params[:search])
				format.html { redirect_to "/folders/" }
		    format.js {render js: @new_folder }
		    format.js {render js: @search_folder }
		  else
			  @search_folder = Folder.where(:user_id => current_user).search(params[:search])
			  format.html { render :action => 'index' }
			  format.js {render js: @new_folder.errors, status: :unprocessable_entity}
		    format.js {render js: @search_folder }
		  end
		end
	end
	def edit
		@search_folder = Folder.where(:user_id => current_user).search(params[:search])
  	@foldersharings = Foldersharing.all
		@folders = Folder.where(:user_id => current_user)
		@new_folder = Folder.find(params[:id])
		respond_to do |format|
			format.html { render action: "index"}
			format.js {render js: @new_folder}
			format.js {render js: @search_folder }
		end
	end

	def show
		# binding.pry
		@folder = Folder.find(params[:id])
		# @search = Filestream.search(params[:search])
		@sort_file=Filestream.order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
		# binding.pry
		# @search_files=@sort_file.
		@uploads = @sort_file.where(:folder_id => params[:id].to_s).search(params[:search])
		# @search_files=@uploads.search(params[:search])
		# @file =@uploads.paginate(:per_page => 5, :page => params[:page])
		@foldersharings = Foldersharing.all
		# binding.pry
		@id = params[:id].to_i
		respond_to do |format|
			if current_user.id.to_s == params[:user_id].to_s
				@folder = Folder.find(@id)
				format.html { render action: "show"}
				# format.js {render js: @folder }
				# format.js {render js: @file }
				format.js {render js: @uploads }
			else
				if Foldersharing.where(:shared_user_id => current_user.id, :folder_id => @id).exists?
					@folder = Folder.find(params[:id])
					format.html
				    format.js {render js: @folder}
			 	else
			 		format.html { redirect_to root_path }
				end
			end
		end
	end

	def update
		@foldersharings = Foldersharing.all
		@new_folder = Folder.find(params[:id])
		@folders = Folder.where(:user_id => current_user)
		respond_to do |format|
			if @new_folder.update_attributes(params[:folder])
				@new_folder = nil
				@search_folder = Folder.where(:user_id => current_user).search(params[:search])
		    format.html {render :action => 'index'}
		    format.js { render js: @new_folder }
		    format.js { render js: @search_folder }
		  else
				@search_folder = Folder.where(:user_id => current_user).search(params[:search])
		    format.html {render :action => 'index'}
		    format.js {render js: @new_folder.errors, status: :unprocessable_entity }
		    format.js { render js: @search_folder }
		  end
		end
	end

	def destroy
		@foldersharings = Foldersharing.all
		@user_id = Folder.find(params[:id]).user_id
		@folder = Folder.find(params[:id])
		@folder.destroy
		respond_to do |format|
		  format.html { redirect_to "/folders"}
    end
	end
  private
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
