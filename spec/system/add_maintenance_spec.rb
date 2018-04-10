require "rails_helper"

RSpec.describe 'Add maintenance request' do

	let(:person){create(:person)}

	before do
		sign_in(person)
	end

	it 'allows a user with rent rights to add a rent payment' do
		property = create(:property)
		worktype = create(:worktype)
		contractor = create(:contractor)
		visit(maintenances_path)
		click_on "Add Job"
		expect(current_path).to eq(new_maintenance_path)
		select "12 Street Road", :from =>'maintenance_property_id'
		select "Electrical", :from =>'maintenance_worktype_id'
		select "Steve Mcqueen", :from =>'maintenance_contractor_id'
		fill_in('Details', with: 're-floored the downstairs')
		fill_in('Cost £', with: '999.99')
		click_on("Submit")
		expect(current_path).to eq(maintenance_path(Maintenance.last))
		expect(page).to have_content("Maintenance work successfully added!")
		expect(page).to have_content("Electrical, (Steve Mcqueen) - £999.99 re-floored the downstairs")
	end
end