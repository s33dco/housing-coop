class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :store_user_location!, if: :storable_location?

private

	def people_rights?
		person_signed_in? && (current_person == @person || current_person.admin? || current_person.secretary?)
	end

	def require_people_rights
		unless people_rights?
			redirect_to people_path, alert: "Admin will need to modify your details to access this area"
		end
	end


	def sec_rights?
		person_signed_in? && (current_person.admin? || current_person.secretary?)
	end

	helper_method :sec_rights?

	def require_sec_rights
		unless sec_rights? || current_person == @person
			redirect_to calendar_path, alert: "Admin will need to modify your details to access this area"
		end
	end

	def property_rights?
		person_signed_in? && ( current_person.admin? || current_person.secretary? || current_person.rent_officer?)
	end

	helper_method :property_rights?

	def require_property_rights
		unless property_rights?
			redirect_to properties_path, alert: "Admin will need to modify your details to access this area"
		end
	end

	def rent_rights?
		person_signed_in? && ( current_person.admin? || current_person.rent_officer?)
	end

	helper_method :rent_rights?

	def require_rent_rights
		unless rent_rights?
			redirect_to rents_path, alert: "Admin will need to modify your details to access this area"
		end
	end

	def maintenance_rights?
		person_signed_in? && ( current_person.admin? || current_person.maintenance?)
	end

	helper_method :maintenance_rights?

	def require_maintenance_rights
		unless maintenance_rights?
			redirect_to maintenances_path, alert: "Admin will need to modify your details to access this area"
		end
	end

	def admin_rights?
		person_signed_in? && current_person.admin?
	end

	helper_method :admin_rights?

	def require_admin_rights
		unless admin_rights?
			redirect_to properties_path, alert: "Admin will need to modify your details to access this area"
		end
	end

	def my_rights?(person)
		person_signed_in? && current_person == person
	end

	helper_method :my_rights?

end
