require 'rails_helper'

RSpec.describe 'total void rent' do 
	it 'sums all the void rent totals from all properties' do 
		property1 = create(:property, name_or_number: 10, void_rent_total:100)
		property2 = create(:property, name_or_number: 11, void_rent_total:100)
		property3 = create(:property, name_or_number: 12, void_rent_total:100)
		property4 = create(:property, name_or_number: 13, void_rent_total:100)
		property5 = create(:property, name_or_number: 14, void_rent_total:100)
		expect(Property.all.total_lost_rent).to eq(500)
	end
end

  