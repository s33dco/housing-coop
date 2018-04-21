class PropertiesController < ApplicationController
  before_action :authenticate_person!
  before_action :require_property_rights, except: [:index, :show]
  before_action :set_property, only: [:show, :edit, :update, :destroy]


	def index
		@properties = Property.by_street_name_number
	end

	def show
    @people = @property.people.members_adults_children
    @payments = @property.rent_paid_by_tenant
    @rent_balance = @property.balance
    @maintenances = @property.maintenances
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
	end

  def update
    if @property.update(property_params)
      redirect_to @property, notice: "Property successfully updated!"
    else
      render :edit
    end
  end

	def destroy
    @property.destroy
    redirect_to properties_url, alert: "Property successfully deleted!"
	end


private

  def set_property
    @property = Property.find_by!(slug: params[:id])
  end

  def property_params
    params.require(:property).
      permit(:name_or_number, :address1, :address2, :postcode, :rent_per_week, 
            :kitchen_upgrade, :coop_house, :first_day_of_next_rent_period, :new_rent_value, 
            :rent_period_start, :moving_out_date, :rent_balance, :end_of_tenancy_balance, :void_rent_total)
  end

end
