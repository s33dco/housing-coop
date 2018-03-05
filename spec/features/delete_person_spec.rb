require 'rails_helper'

describe "Deleting a person" do

	  before do
	    @property = Property.create!(property_attributes)
	  end
  
  it "destroys the person and shows the property page without the deleted person" do
    person = Person.new(person_attributes)
    person.property = @property
    person.save

    visit person_path(person)

    click_link 'Delete'

    expect(current_path).to eq(properties_path)
    expect(page).not_to have_text(person.lastname)
    expect(page).to have_text("Person successfully deleted!")
  end
end
