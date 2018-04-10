require "rails_helper"

RSpec.describe 'Add a new person' do

	let(:person){create(:person)}


	before do
		sign_in(person)
	end

	it 'allows a user with people rights to add a person' do
		property = create(:property)
		visit(people_path)
		click_on "Add a new person"
		expect(current_path).to eq(new_person_path)
		fill_in("First Name(s)", with: 'Derek')
		fill_in("Family Name", with: 'Tester')		
		fill_in("Email", with: 'derek@tester.com')
		fill_in("Password", with: 'password')
		fill_in("person_password_confirmation", with: 'password')
		select "12 Street Road", :from =>'person_property_id'
		select '1', :from => 'person_joined_3i'
		select 'January', :from => 'person_joined_2i'
		select '2018', :from => 'person_joined_1i'
		click_on("Submit")
		expect(current_path).to eq(person_path(Person.last))
		expect(page).to have_content("Derek Tester successfully created!")
	end

	it 'blocks users without people rights from creating perople'


end