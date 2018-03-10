class PropertiesController < ApplicationController

	def index
		@properties = Property.by_street_name_number
	end

	def show
		@property = Property.find(params[:id])
    @people = @property.people.members_adults_children
    @payments = @property.rents
    @rent_balance = @property.balance
	end

	def new
		@property = Property.new
	end

	def create
		@property = Property.new(property_params)
    if @property.save
      redirect_to @property, notice: "Property successfully created!"
    else
      render :new
      @property.errors.full_messages
    end
	end

	def edit
		@property = Property.find(params[:id])
	end

  def update
    @property = Property.find(params[:id])
    if @property.update(property_params)
      redirect_to @property, notice: "Property successfully updated!"
    else
      render :edit
    end
  end

	def destroy
    @property = Property.find(params[:id])
    @property.coop_house = false
    @property.destroy
    redirect_to properties_url, alert: "Property successfully deleted!"
	end




private

  def property_params
    params.require(:property).
      permit(:house_name_no, :address1, :address2, :postcode, :rent_per_week, 
            :kitchen_upgrade, :coop_house, :rent_change, :new_rent_value, 
            :rent_begin, :rent_end)
  end

end
