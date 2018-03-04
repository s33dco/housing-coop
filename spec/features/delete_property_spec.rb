require 'rails_helper'

describe "Deleting a property" do
  
  it "destroys the property and shows the movie listing without the deleted property" do
    property = Property.create!(property_attributes)

    visit property_path(property)

    click_link 'Delete'

    expect(current_path).to eq(properties_path)
    expect(page).not_to have_text(property.address1)
    expect(page).to have_text("Property successfully deleted!")
  end
end
