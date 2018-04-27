class RentsController < ApplicationController
	before_action :authenticate_person!
	before_action :require_rent_rights, except: [:index, :show, :report]

	def index
		if params[:property_id].in? Property.by_street_name_number.map{|p| p.id.to_s}
			@payments = Rent.by_house(params[:property_id])
		else
			@payments = Rent.last_first
		end
		@money = @payments.total
		
		respond_to do |format|
			format.html
			format.csv { send_data @payments.to_csv }
		end
	end

	def show
		@rent = Rent.find(params[:id])
	end

	def new
		@rent = Rent.new
	end

	def create
		@rent = Rent.new(rent_params)
    if @rent.save
      redirect_to @rent, notice: "Payment successfully added!"
    else
      render :new
      @rent.errors.full_messages
    end
	end

	def edit
		@rent = Rent.find(params[:id])
	end

	def update
	  @rent = Rent.find(params[:id])
	  if @rent.update(rent_params)
	    redirect_to @rent, notice: "Payment successfully updated!"
	  else
	    render :edit
	  end
	end

	def destroy
    @rent = Rent.find(params[:id])
    @rent.destroy
    redirect_to rents_url, alert: "Payment successfully deleted!"
	end

	def report
	  @houses = Property.by_street_name_number
	  @total_void_rent = @houses.total_lost_rent
	  @total_above = @houses.current_void_rent
	  @total_lost = @total_void_rent + @total_above
	end


private

  def rent_params
    params.require(:rent).permit(:property_id, :date, :payment, :notes)
  end
 

end
