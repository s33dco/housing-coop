class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def number_and_address1
		"#{self.house_name_no} #{self.address1}"
	end

	def full_name
		"#{self.firstname} #{self.lastname}"
	end

	def downcase_email
	  self.email.downcase!
	end

end
