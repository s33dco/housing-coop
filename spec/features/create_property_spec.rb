require 'rails_helper'

describe 'Creating a Property' do

  it "saves the Property and shows the new property's details" do
    visit properties_url

    click_link 'Add a new property'

    expect(current_path).to eq(new_property_path)

    fill_in "Name or Number", with: "49"
    fill_in "Address 1", with: "golf drive"
    fill_in "Address 2", with: "brIgHton"
    fill_in "Postcode", with: "Bn1 7hz"
    fill_in "Current Rent per week £", with: "70.00"  

    click_button 'Submit'

    expect(current_path).to eq(property_path(Property.last))
    expect(page).to have_text('Property successfully created!')
    expect(page).to have_text('49 Golf Drive')
    expect(page).to have_text('BN1 7HZ')
  end
end
