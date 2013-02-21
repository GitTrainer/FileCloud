class FoldersController < ApplicationController
  before_filter :signed_in_user

  helper_method :sort_column, :sort_direction

   def index
		@foldersharings = Foldersharing.all
		@search_folder = Folder.where(:user_id => current_user).search(params[:search])
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

		@folder = Folder.find(params[:id])
		@sort_file=Filestream.order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
		@uploads = @sort_file.where(:folder_id => params[:id]).search(params[:search])
		@foldersharings = Foldersharing.all

		@id = params[:id].to_i

			if Folder.where(:user_id => current_user.id, :id => @id).exists?
				@folder = Folder.find(@id)
				# format.html { render action: "show"}
				render :action=> 'show'
				# format.js {render js: @uploads }
			else
				if Foldersharing.where(:shared_user_id => current_user.id, :folder_id => @id).exists?
					@folder = Folder.find(params[:id])
					# format.html
				    # format.js {render js: @folder}
			 	else
			 		# format.html { redirect_to root_path }
			 		redirect_to root_path
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

	def folder_download
		# binding.pry
		require 'zip/zip'
 		require 'zip/zipfilesystem'
		@files = Filestream.find_by_sql(["select * from filestreams where folder_id =?",params[:id]])
    t = Tempfile.new('tmp-zip-' + request.remote_ip)
    # binding.pry
    Zip::ZipOutputStream.open(t.path) do |zos|
		  @files.each do |file|
		    zos.put_next_entry(file.attach_file_name)
		    zos.print IO.read(file.attach.path)
		  end
  	end
  	send_file t.path, :type => "application/zip", :filename => "#{User.find(Folder.find(params[:id]).user_id).name}-#{Folder.find(params[:id]).name}-#{Time.now}.zip"
  	t.close
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
