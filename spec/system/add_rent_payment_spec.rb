require "rails_helper"

RSpec.describe 'Add a rent payment' do

	let(:person){create(:person)}

	before do
		sign_in(person)
	end

	it 'allows a user with rent rights to add a rent payment' do
		property = create(:property)
		visit(rents_path)
		click_on "Add Payment"
		expect(current_path).to eq(new_rent_path)
		select "12 Street Road", :from =>'rent_property_id'
		select '1', :from => 'rent_date_3i'
		select 'January', :from => 'rent_date_2i'
		select '2018', :from => 'rent_date_1i'
		fill_in("Payment Amount £", with: '70')
		fill_in("Notes", with: 'test rent payment')	
		click_on("Submit")
		expect(current_path).to eq(rent_path(Rent.last))
		expect(page).to have_content("test rent payment")
	end
end