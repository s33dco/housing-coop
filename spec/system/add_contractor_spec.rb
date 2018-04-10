require "rails_helper"

RSpec.describe 'Add a Contractor' do

	let(:person){create(:person)}

	before do
		sign_in(person)
	end

	it 'allows a user with maintenance rights to add a contractor' do
		visit(contractors_path)
		click_on "Add a contractor"
		expect(current_path).to eq(new_contractor_path)
		fill_in("Contractor's name", with: 'Sparky Lecky')
		fill_in('Phone', with: '07123456789')
		fill_in('Email', with: 'sparks@volts.com')
		fill_in('Details', with: 'excellent electrician')
		click_on("Submit")
		expect(current_path).to eq(contractors_path)
		expect(page).to have_content("Contractor successfully added!")
	end
end