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

# for phone numbers
	def telephone(phone)
		number_to_phone(phone, pattern: /(\d{5})(\d{6})/, delimiter: " ")
	end

# for money
	def show_money(money)
		number_to_currency(money, unit: "£")
	end

	def rent_per_month(per_week)
		per_month = (per_week*52)/12
		number_to_currency(per_month, unit: "£")
	end

	def rent_per_day(per_week)
		per_day = (per_week/7)
		number_to_currency(per_day, unit: "£")
	end

# date formats

	def nice_short_date(t)
		t.strftime("#{t.day.ordinalize} %B %Y")	
	end

	def update_day(d)
		d.strftime("updated #{d.day.ordinalize} %b")	
	end

	def short_date(d)
		d.strftime("%d/%m/%y")	
	end

	def month_year(d)
		d.strftime("%B '%y")	
	end
end
