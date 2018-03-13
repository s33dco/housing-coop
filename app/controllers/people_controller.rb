class PeopleController < ApplicationController
	def index
		@people = Person.housed
    @roles = Role.current
	end

	def show
		@person = Person.find(params[:id])
    @roles = @person.roles
	end

	def new
		@person = Person.new
	end

	def create
		@person = Person.new(person_params)
    if @person.save
      redirect_to @person, notice: "Person successfully created!"
    else
      render :new
      @person.errors.full_messages
    end
	end

	def edit
		@person = Person.find(params[:id])
	end

  def update
    @person = Person.find(params[:id])
    if @person.update(person_params)
      redirect_to @person, notice: "Person successfully updated!"
    else
      render :edit
    end
  end

	def destroy
    @person = Person.find(params[:id])
    @person.destroy
    redirect_to properties_url, alert: "Person successfully deleted!"
	end

private

  def person_params
    params.require(:person).
      permit(:firstname, :lastname, :email, :phone, :joined, :exit, :member, :housed, :child, :secretary, :rent_officer, :admin, :words, :property_id)
  end

end
