require "rails_helper"

RSpec.describe 'Allocate Roles' do

	let(:person){create(:person)}

	before do
		sign_in(person)
	end

	it 'allows a user with people rights to add a Job type' do
		job = create(:job)
		visit(roles_path)
		click_on "Allocate Role"
		expect(current_path).to eq(new_role_path)
		select'Percy Parker', :from =>"role_person_id"
		select'Secretary',:from =>'role_job_id'
		select('20', :from => 'role_role_start_3i')
		select('January', :from => 'role_role_start_2i')
		select('2018', :from => 'role_role_start_1i')
		select('20', :from => 'role_role_end_3i')
		select('January', :from => 'role_role_end_2i')
		select('2019', :from => 'role_role_end_1i')
		click_on("Submit")
		expect(current_path).to eq(roles_path)
		expect(page).to have_content("Role successfully allocated!")
	end
end