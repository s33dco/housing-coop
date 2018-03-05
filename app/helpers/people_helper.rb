module PeopleHelper

	def resident_since(person)
		if person.joined == nil
			content_tag(:p, "please confirm the date you moved in")
		else
			time = 'for '
			amount = time_ago_in_words(person.joined)
			time << amount
		end
	end

	def address_helper(person)
		address = person.property.house_number
		address << " " << person.property.address1
	end
end
