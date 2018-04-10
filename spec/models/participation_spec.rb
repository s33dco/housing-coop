require 'rails_helper'

RSpec.describe Participation do 

	let(:participation){build_stubbed(:participation)}

	it "requires a calendar event" do
	  participation.calendar = nil
	  participation.valid?  
	  expect(participation.errors[:calendar].any?).to eq(true)
	end	

	it "requires a person" do
	  participation.person = nil
	  participation.valid?  
	  expect(participation.errors[:person].any?).to eq(true)
	end	
end