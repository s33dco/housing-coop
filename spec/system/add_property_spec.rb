require "rails_helper"

RSpec.describe 'Adding a new property' do

	let(:person){create(:person)}

	before do
		sign_in(person)
	end

	it 'allows an admin to create a property with full rent details' do
		visit(properties_path)
		click_on "Add a Property"
		fill_in("property[name_or_number]", with: '1')
		fill_in("Address 1", with: 'Street Road')
		fill_in("Address 2", with: 'London')
		fill_in("Postcode", with: 'w1a 1aa')
		fill_in("Current Rent per week £", with: '100.00')
		select('1', :from => 'property_rent_period_start_3i')
		select('January', :from => 'property_rent_period_start_2i')
		select('2018', :from => 'property_rent_period_start_1i')
		select('31', :from => 'property_moving_out_date_3i')
		select('December', :from => 'property_moving_out_date_2i')
		select('2018', :from => 'property_moving_out_date_1i')
		fill_in("Future Rent per week £", with: '200.00')
		select('1', :from => 'property_first_day_of_next_rent_period_3i')
		select('January', :from => 'property_first_day_of_next_rent_period_2i')
		select('2019', :from => 'property_first_day_of_next_rent_period_1i')
		click_on("Submit")
		expect(current_path).to eq(property_path(Property.last))
		expect(page).to have_content("1 Street Road, London, W1A 1AA")
		expect(page).to have_content("Rent is currently charged at £100.00 per week.") 
		expect(page).to have_content("This is scheduled to change to £200.00 per week as of the 1st January 2019.")
	end

	it 'allows a secretary to create a property with minimal rent details' do
		person.admin = false
		person.secretary = true
		person.save
		visit(properties_path)
		click_on "Add a Property"
		expect(current_path).to eq(new_property_path)
		fill_in "property[name_or_number]", with: '12'
		fill_in "Address 1", with: 'Street Road'
		fill_in "Address 2", with: 'London'
		fill_in "Postcode", with: 'w1a 1aa'
		fill_in "Current Rent per week £", with: '100.00'
		select '1', :from => 'property_rent_period_start_3i'
		select 'January', :from => 'property_rent_period_start_2i'
		select '2018', :from => 'property_rent_period_start_1i'
		click_on("Submit")
		expect(current_path).to eq(property_path(Property.last))
		expect(page).to have_content("12 Street Road, London, W1A 1AA")
		expect(page).to have_content("Rent is currently charged at £100.00 per week.") 
	end
end
