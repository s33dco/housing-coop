class ContractorsController < ApplicationController

		def index
			@contractors = Contractor.alphabetically
		end

		def show
			@contractor = Contractor.find(params[:id])
		end

		def new
			@contractor = Contractor.new
		end

		def create
			@contractor = Contractor.new(contractor_params)
	    if @contractor.save
	      redirect_to @contractor, notice: "Contractor successfully added!"
	    else
	      render :new
	      @contractor.errors.full_messages
	    end
		end

		def edit
			@contractor = Contractor.find(params[:id])
		end

		def update
		  @contractor = Contractor.find(params[:id])
		  if @contractor.update(contractor_params)
		    redirect_to @contractor, notice: "Contractor successfully updated!"
		  else
		    render :edit
		  end
		end

		def destroy
	    @contractor = Contractor.find(params[:id])
	    @contractor.destroy
	    redirect_to rents_url, alert: "Contractor successfully deleted!"
		end


	private

	  def contractor_params
	    params.require(:contractor).permit(:name, :details, :email, :details, :use, :phone)
	  end
end
