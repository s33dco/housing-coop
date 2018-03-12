class WorktypesController < ApplicationController

		def index
			@worktypes = Worktype.alphabetically
		end

		def new
			@worktype = Worktype.new
		end

		def create
			@worktype = Worktype.new(worktype_params)
	    if @worktype.save
	      redirect_to worktypes_url, notice: "New category added"
	    else
	      render :new
	      @worktype.errors.full_messages
	    end
		end

		def edit
			@worktype = Worktype.find(params[:id])
		end

		def update
		  @worktype = Worktype.find(params[:id])
		  if @worktype.update(worktype_params)
		    redirect_to worktypes_url, notice: "Category updated!"
		  else
		    render :edit
		  end
		end

		def destroy
	    @worktype = Worktype.find(params[:id])
	    @worktype.destroy
	    redirect_to worktypes_url, alert: "Category successfully deleted!"
		end


	private

	  def worktype_params
	    params.require(:worktype).permit(:title)
	  end
	  
end

