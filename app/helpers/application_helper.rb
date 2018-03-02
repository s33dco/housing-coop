module ApplicationHelper
# for page titles and meta descriptions

  def title(title)
  	content_for(:title, title)
  end

	def page_title
  	if content_for?(:title)
  		"#{content_for(:title)} | #{ENV['COOP_SHORT_NAME']}"
  	else
  		"#{ENV['COOP_NAME']}"
  	end
  end

  def description(description)
  	content_for(:description, description)
  end

	def page_description
  	if content_for?(:description)
  		"#{content_for(:description)}"
  	else
  		"#{ENV['COOP_DESCRIPTION']}"
  	end
  end

# for people

	def full_name(person)
			name = person.first_name 
			name << " " << person.last_name
	end

# for one line address
	def home_address(property)
		address = property.house_number
		address << " " << property.address1 << property.postcode
	end

# set currency
	def show_money(money)
		number_to_currency(money, unit: "£")
	end

# date formats
	def nice_date(t)
		t.strftime("%A the #{t.day.ordinalize} %B %Y")	
	end

	def update_day(d)
		d.strftime("updated #{d.day.ordinalize} %b")	
	end

	def short_date(d)
		d.strftime("%d/%m/%y")	
	end

end
