require "rails_helper"

RSpec.describe 'Add a Work Category' do

	let(:person){create(:person)}

	before do
		sign_in(person)
	end

	it 'allows a user with maintenance rights to add a work category' do
		visit(worktypes_path)
		click_on "Add A New Work Type"
		expect(current_path).to eq(new_worktype_path)
		fill_in("Category of Work", with: 'Hairdressing')
		click_on("Submit")
		expect(current_path).to eq(worktypes_path)
		expect(page).to have_content("New category added!")
	end
end