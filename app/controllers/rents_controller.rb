class RentsController < ApplicationController

	def index
		@payments = Rent.all
	end

	def show
		@payment = Rent.find(params[:id])
	end

	def new
		@payment = Rent.new
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
		@payment = Rent.find(params[:id])
	end

	def update
	  @payment = Rent.find(params[:id])
	  if @payment.update(rent_params)
	    redirect_to @payment, notice: "Payment successfully updated!"
	  else
	    render :edit
	  end
	end

	def destroy
    @payment = Rent.find(params[:id])
    @payment.destroy
    redirect_to rents_url, alert: "Payment successfully deleted!"
	end










private

  def rent_params
    params.require(:rent).permit(:property_id, :date, :payment, :notes)
  end
  

end
