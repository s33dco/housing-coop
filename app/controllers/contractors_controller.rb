class ContractorsController < ApplicationController

	before_action :authenticate_person!
	before_action :require_maintenance_rights, except: [:index, :show, :list]
	before_action :set_contractor, only: [:show, :edit, :update, :destroy]

	def index
		@contractors = Contractor.alphabetically
	end

	def list
		@contractors = Contractor.alphabetically
	end

	def show
    @previous_work = @contractor.maintenances
	end

	def new
		@contractor = Contractor.new
	end

	def create
		@contractor = Contractor.new(contractor_params)
    if @contractor.save
      redirect_to contractors_path, notice: "Contractor successfully added!"
    else
      render :new
      @contractor.errors.full_messages
    end
	end

	def edit
	end

	def update
	  if @contractor.update(contractor_params)
	    redirect_to contractors_path, notice: "Contractor successfully updated!"
	  else
	    render :edit
	  end
	end

	def destroy
    @contractor.destroy
    redirect_to contractors_path, alert: "Contractor successfully deleted!"
	end

private

	def set_contractor
	  @contractor = Contractor.find_by!(slug: params[:id])
	end

  def contractor_params
    params.require(:contractor).permit(:name, :details, :email, :details, :use, :phone)
  end
end
