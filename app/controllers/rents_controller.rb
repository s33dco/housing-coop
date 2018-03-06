class RentsController < ApplicationController

	def index
		@rents = Rent.all
	end

	def show
		@rent = Rent.find(params[:id])
	end

	def new
		@rent = Rent.new
	end

	def create
		@payment = Rent.new(rent_params)
    if @payment.save
      redirect_to @payment, notice: "Payment successfully added!"
    else
      render :new
      @payment.errors.full_messages
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










private

  def rent_params
    params.require(:rent).permit(:property_id, :date, :payment, :notes)
  end
  

end
