class CalendarsController < ApplicationController
	before_action :authenticate_person!
	
	def index
		@events = Calendar.future_to_past
	end

	def upcoming
		@events = Calendar.upcoming
	end

	def show
		@event = Calendar.find(params[:id])
		@attended = @event.people
	end

	def new
		@event = Calendar.new
	end

	def create
		@event = Calendar.new(calendar_params)
		if @event.save
			  redirect_to calendars_path, notice: "It's in the diary!"
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
		  redirect_to calendars_path, notice: "Event successfully updated!"
		else
		  render :edit
		end
	end

	def destroy
		@event = Calendar.find(params[:id])
		@event.destroy
		redirect_to calendars_path, alert: "Event successfully deleted!"
	end

private

	def calendar_params
		 params.require(:calendar).permit(:date_time, :where, :title, :details, :link, :person_ids => [])
			
		end	
end
