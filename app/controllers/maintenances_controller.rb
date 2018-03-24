class MaintenancesController < ApplicationController
			def index
				@maintenances = Maintenance.first_job_first
				@money = @maintenances.total
			end

			def show
				@maintenance = Maintenance.find(params[:id])
			end

			def new
				@maintenance = Maintenance.new
			end

			def create
				@maintenance = Maintenance.new(maintenance_params)
		    if @maintenance.save
		      redirect_to @maintenance, notice: "Maintenance work successfully added!"
		    else
		      render :new
		      @maintenance.errors.full_messages
		    end
			end

			def edit
				@maintenance = Maintenance.find(params[:id])
			end

			def update
			  @maintenance = Maintenance.find(params[:id])
			  if @maintenance.update(maintenance_params)
			    redirect_to @maintenance, notice: "Maintenance successfully updated!"
			  else
			    render :edit
			  end
			end

			def destroy
		    @maintenance = Maintenance.find(params[:id])
		    @maintenance.destroy
		    redirect_to rents_url, alert: "Maintenance successfully deleted!"
			end


		private

		  def maintenance_params
		    params.require(:maintenance).permit(:worktype_id, :contractor_id, :cost, :property_id, :details, :date)
		  end


	end

