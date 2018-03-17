require 'rails_helper'

describe 'Creating a Property' do

  it "saves the Property and shows the new property's details" do
    visit properties_path

    click_link 'Add a new property'

    expect(current_path).to eq(new_property_path)
    expect(page).to have_text('Add New Property')

    fill_in "Name or Number", with: "49"
    fill_in "Address 1", with: "golf drive"
    fill_in "Address 2", with: "brIgHton"
    fill_in "Postcode", with: "Bn1 7hz"
    fill_in "Current Rent per week £", with: "70.00" 
    select (Time.now.day), :from => "last_day_of_rent_period_1i"
    select (Time.now.month), :from => "last_day_of_rent_period_2i"
    select (Time.now.year), :from => "last_day_of_rent_period_3i"

    click_button 'Submit'

    expect(current_path).to eq(property_path(Property.last))
    expect(page).to have_text('Property successfully created!')
    expect(page).to have_text('49 Golf Drive')
    expect(page).to have_text('BN1 7HZ')
  end
end
