class FoldertreesController < ApplicationController
before_filter :signed_in_user
	def index
		if @new_foldertree.nil?
		  @new_foldertree = Foldertree.new
		end
	@foldertrees = Foldertree.where(:parentID => params[:pID])
		 	respond_to do |format|
				format.html { render action: "index"}
				format.js {render js: @new_folderchild }
			  format.js {render js: @foldertrees }
			end
  end

	def create
		@new_foldertree = Foldertree.new(params[:foldertree])
		@foldertrees = Foldertree.where(:parentID => params[:pID])
		respond_to do |format|
		  if @new_foldertree.save
			  @new_foldertree = nil
			  format.html { redirect_to ("/foldertrees/?pID="+params[:foldertree][:parentID])}
		    format.js {render js: @new_foldertree }
		    format.js {render js: @foldertrees }
		  else
			  format.html { redirect_to ("/foldertrees/?pID="+params[:foldertree][:parentID])}
			  format.js {render js: @new_foldertree.errors, status: :unprocessable_entity}
		    format.js {render js: @foldertrees  }
		  end
		end
	end

	def edit
		@foldertrees = Foldertree.where(:parentID => params[:pID])
		@new_foldertree = Foldertree.find(params[:id])
		respond_to do |format|
			format.html { render action: "index"}
			format.js {render js: @new_foldertree}
			format.js {render js: @foldertrees }
		end
	end

	def update
		@new_foldertree = Foldertree.find(params[:id])
		@foldertrees = Foldertree.where(:parentID => params[:pID])
			if @new_foldertree.update_attributes(params[:foldertree])
				@new_foldertree = nil
		    redirect_to ("/foldertrees/?pID="+params[:foldertree][:parentID])
		  else
		    redirect_to ("/foldertrees/"+params[:id]+ "/edit/?pID="+ params[:foldertree][:parentID])
		    flash[:error] = "Please fill fields correctly!"
		end
	end

	def destroy
		pID = Foldertree.where(:id => params[:id]).first.parentID
		del = Foldertree.find(params[:id])
		del.destroy
		redirect_to ("/foldertrees/?pID="+ pID.to_s)
	end

		def show
			binding.pry
			@foldertree = Foldertree.find(params[:id])
			@id = params[:id].to_i
			render :action=> 'show'
		end



	private
	  def signed_in_user
	    unless signed_in?
	      store_location
	      redirect_to signin_url, notice: "Please sign in."
	    end
  end
end
