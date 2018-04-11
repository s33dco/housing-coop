require "rails_helper"

RSpec.describe 'Add Job for Roles' do

	let(:person){create(:person)}

	before do
		sign_in(person)
	end

	it 'allows a user with people rights to add a Job type' do
		visit(roles_path)
		click_on "Manage Titles"
		expect(current_path).to eq(jobs_path)
		click_on "Add a Role"
		fill_in("Officer Role", with: 'Head Chef')
		fill_in('Officer Email', with: 'head@chef.com')
		click_on("Submit")
		expect(current_path).to eq(jobs_path)
		expect(page).to have_content("Job successfully added!")
	end
end