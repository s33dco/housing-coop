require 'rails_helper'

describe 'Creating a Person' do
  before do
    @property = Property.create!(property_attributes)
  end

  it "saves the person and shows the new person's details" do
    visit people_url

    click_link 'Add a new person'

    expect(current_path).to eq(new_person_path)

    fill_in "First Name(s)", with: "Ian"
    fill_in "Family Name", with: "mArLeY"
    fill_in "Email", with: "code@s33d.co"
    fill_in "Phone #", with: "077777777777"
    select "1 Electric Avenue", from: "Choose Property"
 

    click_button 'Submit'

    expect(current_path).to eq(person_path(Person.last))
    expect(page).to have_text('Person successfully created!')
    expect(page).to have_text('Ian')
    expect(page).to have_text('Marley')
    expect(page).to have_text('code@s33d.co')
    expect(page).to have_text('077777777777')
  end
end
