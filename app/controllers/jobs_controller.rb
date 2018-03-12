class JobsController < ApplicationController

		def index
			@jobs = Job.alphabetically
		end

		def show
			@job = Job.find(params[:id])
		end

		def new
			@job = Job.new
		end

		def create
			@job = Job.new(job_params)
	    if @job.save
	      redirect_to jobs_path, notice: "Job successfully added!"
	    else
	      render :new
	      @job.errors.full_messages
	    end
		end

		def edit
			@job = Job.find(params[:id])
		end

		def update
		  @job = Job.find(params[:id])
		  if @job.update(job_params)
		    redirect_to @job, notice: "Job successfully updated!"
		  else
		    render :edit
		  end
		end

		def destroy
	    @job = Job.find(params[:id])
	    @job.destroy
	    redirect_to rents_url, alert: "Job successfully deleted!"
		end


	private

	  def job_params
	    params.require(:job).permit(:title)
	  end
end
