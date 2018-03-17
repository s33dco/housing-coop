require 'rails_helper'

describe "Calculates rent balance" do

	it "due using default attributes" do
		property = Property.create!(property_attributes)
		visit property_path(property)
		expect(page).to have_text('-£150.00 (arrears)')
	end

	it "due from a start date with no rent change" do
		property = Property.create!(property_attributes(rent_period_start: Time.now.to_date - 2.weeks, last_day_of_rent_period: ""))
		visit property_path(property)
		expect(page).to have_text('-£150.00 (arrears)')
	end

	it "due over a rent change period" do
		property = Property.create!(property_attributes(rent_period_start: Time.now.to_date - 4.weeks, last_day_of_rent_period: Time.now.to_date - 15.days, first_day_of_next_rent_period: Time.now.to_date - 2.weeks, new_rent_value: 140))
		visit property_path(property)
		expect(page).to have_text('-£440.00 (arrears)')
	end


	it 'due from first day of tenancy until current day with no rent change subtracting any rent payments made against that property within the period'	

	it 'due from first day of tenancy until current day with a rent change subtracting any rent payments made against that property within the period'	


end