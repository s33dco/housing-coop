class CalendarsController < ApplicationController
	def index
		@events = Calendar.upcoming
	end

	def upcoming
		@events = Calendar.upcoming
	end

	def show
		@event = Calendar.find(params[:id])
	end

	def new
		@event = Calendar.new
	end

	def create
		@event = Calendar.new(calendar_params)
		if @event.save
			  redirect_to @event, notice: "It's in the diary!"
			else
			  render :new
			  @event.errors.full_messages
			end
	end

	def edit
		@event = Calendar.find(params[:id])
	end

	def update
		@event = Calendar.find(params[:id])
		if @event.update(calendar_params)
		  redirect_to @event, notice: "Event successfully updated!"
		else
		  render :edit
		end
	end

	def destroy
		@event = Calendar.find(params[:id])
		@event.destroy
		redirect_to calendars_path, alert: "Person successfully deleted!"
	end

private

	def calendar_params
		 params.require(:calendar).permit(:date_time, :where, :title, :details, :link)
			
		end	
end
