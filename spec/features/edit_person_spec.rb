require 'rails_helper'

describe "Editing a person" do

  before do
    @property = Property.create!(property_attributes)
  end

  it "updates the person and shows the person's updated details" do
    person = Person.new(person_attributes)
    person.property = @property
    person.save

    visit person_url(person)

    click_link 'Edit'

    expect(current_path).to eq(edit_person_path(person))

    expect(find_field("First Name").value).to eq(person.firstname)

    fill_in "First Name", with: "Delbert"

    click_button 'Submit'

    expect(current_path).to eq(person_path(person.reload))

    expect(page).to have_text(person.lastname)
    expect(page).to have_text('Person successfully updated!')
  end

  it "does not update the person if details invalid" do
    person = Person.new(person_attributes)
    person.property = @property
    person.save
    
    visit edit_person_url(person)
    
    fill_in "First Name", with: " "
    
    click_button 'Submit' 
        
    expect(page).to have_text('error')
  end

end