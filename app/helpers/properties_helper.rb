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
		if property.moving_out_date == nil
			time_ago_in_words(property.updated_at)
		else
			time_ago_in_words(property.moving_out_date)
		end
	end

end
