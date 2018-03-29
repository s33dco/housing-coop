class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

private

	def sec_rights?
		person_signed_in? && ( current_person.admin? || current_person.secretary?)
	end

	helper_method :sec_rights?

	def property_rights?
		person_signed_in? && ( current_person.admin? || current_person.secretary? || current_person.rent_officer?)
	end

	helper_method :property_rights?

	def rent_rights?
		person_signed_in? && ( current_person.admin? || current_person.rent_officer?)
	end

	helper_method :rent_rights?

	def maintenance_rights?
		person_signed_in? && ( current_person.admin? || current_person.maintenance?)
	end

	helper_method :maintenance_rights?

	def admin_rights?
		person_signed_in? && current_person.admin?
	end

	helper_method :admin_rights?

	def my_rights?(person)
		person_signed_in? && current_person == person
	end

	helper_method :my_rights?

# 	def require_admin
# 	  unless current_user_admin?
# 	    redirect_to root_url, alert: "Unauthorized access!"
# 	  end
# 	end

end
