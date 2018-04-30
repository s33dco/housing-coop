Property.create!({
	name_or_number:'1', 
	address1:'Test Street',
	address2:'Test Town',
	postcode:'W1 1AA', 
	rent_per_week:70.00,
	coop_house: true,
	moving_out_date: 7.days.ago
	
								})

Person.create!({
	firstname:'super', 
	lastname:'user',
	phone:'07123456789',
	joined: Time.now.to_date,
	member: true,
	housed:true,
	admin:true,
	property_id: 1,
	words: 'this is a test user you can change these details to your own or create another admin user and delete this one',
	child: false,
	email: 'superuser@test.com',
	password: 'password',
	password_confirmation: 'password'
								})





