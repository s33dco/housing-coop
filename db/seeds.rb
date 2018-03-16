Property.create!([{
	name_or_number:'1', 
	address1:'Test Street',
	address2:'Test Town',
	postcode:'W1 1AA', 
	rent_per_week:70.00,
	coop_house: true
	last_day_of_rent_period: (Time.now.to_date - 1)
								}])





