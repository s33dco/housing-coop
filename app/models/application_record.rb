class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def number_and_address1
		"#{self.name_or_number} #{self.address1}"
	end

  def full_address
		"#{self.name_or_number} #{self.address1} #{self.address2} #{self.postcode}"
	end

	def full_name
		"#{self.firstname} #{self.lastname}"
	end

	def downcase_email
	  self.email.downcase!
	end

	def meetings_since_member
	  select{| event | person_ids.event.date_time > @person.joined}.size
	end

end
