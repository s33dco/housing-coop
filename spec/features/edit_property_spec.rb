require 'rails_helper'

describe "Editing a property" do

  it "updates the property and shows the property's updated details" do
    property = Property.create!(property_attributes)

    visit property_url(property)

    click_link 'Edit'

    expect(current_path).to eq(edit_property_path(property))

    expect(find_field("Name or Number").value).to eq(property.house_name_no)

    fill_in "Name or Number", with: "50"

    click_button 'Submit'

    expect(current_path).to eq(property_path(property.reload))

    expect(page).to have_text(property.house_name_no)
    expect(page).to have_text('Property successfully updated!')
  end

  it "does not update the movie if it's invalid" do
    property = Property.create!(property_attributes)
    
    visit edit_property_url(property)
    
    fill_in "Property name or number", with: " "
    
    click_button 'Submit' 
        
    expect(page).to have_text('error')
  end

end