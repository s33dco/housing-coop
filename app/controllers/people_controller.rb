class PeopleController < ApplicationController
  before_action :authenticate_person!
  before_action :set_person, only: [:show, :edit, :update, :destroy]

	def index
		@people = Person.housed
    @roles = Role.current
	end

  def participation
    @people = Person.members
    @events = Calendar.all
  end

	def show
    @roles = @person.roles
	end

	def new
		@person = Person.new
	end

	def create
		@person = Person.new(person_params)
    if @person.save
      redirect_to @person, notice: "#{@person.firstname} #{@person.lastname} successfully created!"
    else
      render :new
      @person.errors.full_messages
    end
	end

	def edit
	end

  def update
    if @person.update(person_params)
      redirect_to @person, notice: "#{@person.firstname} #{@person.lastname} successfully updated!"
    else
      render :edit
    end
  end

	def destroy
    @person.destroy
    redirect_to people_path, alert: "#{@person.firstname} #{@person.lastname} successfully deleted!"
	end

private

  def set_person
    @person = Person.find_by!(slug: params[:id])
  end

  def person_params
    params.require(:person).
      permit(:firstname, :lastname, :email, :phone, :joined, :exit, :member, :housed, :child, :secretary, :rent_officer, :admin, :words, :property_id, :password_confirmation, :password)
    end

end
