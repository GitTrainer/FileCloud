class FoldersController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :correct_user_index, only: [:index]

  def correct_user_index
    if params[:user_id].to_s != current_user.id.to_s
      redirect_to root_path
    end
  end

  def correct_user
      if Folder.where(:user_id=> current_user.id , :id => params[:id]).blank?
         redirect_to root_path
      end
   end

	def index
		@folder = Folder.paginate(page: params[ :page], :per_page => 3)
    @filestream = Filestream.paginate(page: params[ :page], :per_page => 3)
		@foldersharings = Foldersharing.all
		@folders = Folder.where(:user_id => current_user)
		if ( @new_folder.nil?)
			@new_folder = Folder.new
		end
     	 respond_to do |format|
        format.html { render action: "index"}
        format.js {render js: @new_folder }
        format.js {render js:  @folders }
      end
	  end

	def new
		@folder = Folder.paginate(page: params[ :page], :per_page => 3)
    @filestream = Filestream.paginate(page: params[ :page], :per_page => 3)
  	@foldersharings = Foldersharing.all
	  @new_folder = Folder.new
	end

	def create
    @foldersharings = Foldersharing.all
		@folder = Folder.paginate(page: params[ :page], :per_page => 3)
    @filestream = Filestream.paginate(page: params[ :page], :per_page => 3)
		@foldersharings = Foldersharing.all
		@new_folder = Folder.new(params[:folder])
		@folders = Folder.where(:user_id => current_user)
		respond_to do |format|
		  if @new_folder.save
			  @new_folder = nil
				format.html { redirect_to "/folders/?user_id=" + params[:folder][:user_id]}
		      format.js {render js: @new_folder }
		      format.js {render js: @folders }
		  else
		  	flash[:error] = "Please fill all fields correctly"
		    format.html { redirect_to "/folders/?user_id=" + params[:folder][:user_id]}
		  end
		end
	end

	def edit
	    @folder = Folder.paginate(page: params[ :page], :per_page => 3)
  		@foldersharings = Foldersharing.all
		@folders = Folder.where(:user_id => current_user)
		@new_folder = Folder.find(params[:id])
		respond_to do |format|
			format.html { render action: "index"}
			format.js {render js: @new_folder}
			format.js {render js: @folders }
		end
	end

	def show

		@folder = Folder.find(params[:id])
		@uploads = Filestream.where(:folder_id => params[:id])
		@file =@uploads.paginate(:page => params[:page], :per_page => 5)
		@folder = Folder.paginate(page: params[ :page], :per_page => 3)
    @filestream = Filestream.paginate(page: params[ :page], :per_page => 3)
		@foldersharings = Foldersharing.all
		@id = params[:id].to_i
		respond_to do |format|
			if current_user.id.to_s == params[:user_id].to_s
				@folder = Folder.find(@id)
				format.html { render action: "show"}
				format.js {render js: @folder }
				format.js {render js: @file }
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
		    format.html { redirect_to "/folders/?user_id=" + params[:folder][:user_id]}
		    format.js { render js: @new_folder }
		  else
		    format.html {  render action: "index"}
		    format.js {render js: @new_folder.errors, status: :unprocessable_entity}
		    format.js {render js: @folders }
		  end
		end
	end

	def destroy
		@foldersharings = Foldersharing.all
		@user_id = Folder.find(params[:id]).user_id
		@folder = Folder.find(params[:id])
		@folder.destroy
		respond_to do |format|
		  format.html { redirect_to "/folders/?user_id=" + @user_id.to_s }
    end
	end

  private
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end
end
