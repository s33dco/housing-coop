module ApplicationHelper

	def resident_helper(person)
			name = person.first_name 
			name << " " << person.last_name
	end

	def house_helper(property)
		address = property.house_number
		address << " " << property.address1 << property.postcode
	end

	def show_money(money)
		number_to_currency(money, unit: "£")
	end

	def day_helper(t)
		t.strftime("%A the #{t.day.ordinalize} %B %Y")	
	end

	def update_day(d)
		d.strftime("updated #{d.day.ordinalize} %b")	
	end

	def short_date(d)
		d.strftime("%d/%m/%y")	
	end

	def page_title
  	if content_for?(:title)
  		"#{content_for(:title)} | Housing Coop"
  	else
  		"Housing Coop"
  	end
  end

  def title(title)
  	content_for(:title, title)
  end

	def page_description
  	if content_for?(:description)
  		"#{content_for(:description)}"
  	else
  		"Housing Coop"
  	end
  end

  def description(description)
  	content_for(:description, description)
  end
end
