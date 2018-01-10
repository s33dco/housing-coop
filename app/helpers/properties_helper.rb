module PropertiesHelper

	def kitchen_year(property)
		if property.kitchen_upgrade == nil
			content_tag(:p, 'Please update')
		else
			from_time = Time.now
			distance_of_time_in_words(from_time, property.kitchen_upgrade) 
		end
	end

	def empty(property)
		last_in = property.updated_at
		time_ago_in_words(last_in)
	end

end
