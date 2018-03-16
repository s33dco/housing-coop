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
		if property.last_day_of_rent_period == nil
			time_ago_in_words(property.updated_at)
		else
			time_ago_in_words(property.last_day_of_rent_period)
		end
	end

end
