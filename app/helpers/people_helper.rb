module PeopleHelper

	def resident_since(person)
		if person.moved_in == nil
			content_tag(:p, "please confirm the date you moved in")
		else
			time_ago_in_words(person.moved_in)
		end
	end

	def address_helper(person)
		address = person.property.house_number
		address << " " << person.property.address1
	end
end
