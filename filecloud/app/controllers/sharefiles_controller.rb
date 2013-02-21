class SharefilesController < ApplicationController
	before_filter :require_existing_upload, :except => [:index]

	def new
		 # binding.pry
		@sharefile = @upload.sharefiles.build
	end

	def create
		# binding.pry
		@sharefiles = @upload.sharefiles.build(params[:sharefile])

		if @sharefiles.save
			UserMailer.share_link_email(current_user,@sharefiles).deliver
			redirect_to @folder, notice: 'Sharefile was successfully!!!'
		else
			# redirect_to @new_upload_sharefile, notice: 'Email not is empty.'
			# binding.pry
			# redirect_to @folder ,notice: 'Email not is empty.'
			render :action => 'new'
		end
	end

	def index
		
	end

	private 

	def require_existing_upload
		# if params[:upload_id].blank?
		# 	Upload.find(params[:upload_id])
		# else
		# 	redirect_to folder_url
		# end
		# binding.pry
		 # @upload = params[:upload_id].blank? ? Sharefile.file_for_token(params[:id]) : Upload.find(params[:upload_id])
		 @upload = Upload.find(params[:upload_id])
		 @folder = @upload.folder
	end
end
