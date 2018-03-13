class RolesController < ApplicationController
			def index
				@roles = Role.current
			end

			def new
				@role = Role.new
			end

			def create
				@role = Role.new(role_params)
		    if @role.save
		      redirect_to roles_path, notice: "Role work successfully added!"
		    else
		      render :new
		      @role.errors.full_messages
		    end
			end

			def edit
				@role = Role.find(params[:id])
			end

			def update
			  @role = Role.find(params[:id])
			  if @role.update(role_params)
			    redirect_to roles_path, notice: "Role successfully updated!"
			  else
			    render :edit
			  end
			end

			def destroy
		    @role = Role.find(params[:id])
		    @role.destroy
		    redirect_to roles_path, alert: "Role successfully deleted!"
			end


		private

		  def role_params
		    params.require(:role).permit(:role_start, :role_end, :job_id, :person_id)
		  end
	end

