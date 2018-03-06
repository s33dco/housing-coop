require 'rails_helper'

describe 'a rent payment' do 
	it "is valid with example attributes" do
		property = Property.create!(property_attributes)
    rent = Rent.new(rent_attributes)
    rent.property = property

    expect(rent.valid?).to eq(true)
  end

  it "requires a payment value" do
    rent = Rent.new(payment: "")
    rent.valid?  
    expect(rent.errors[:payment].any?).to eq(true)
  end

  it "rejects invalid payment values" do
  	payments = %w[-125.44 fiftyquid toomuch!]
  	payments.each do |payment|  
	    rent = Rent.new(rent_attributes(payment: payment))
	    rent.valid?  
	    expect(rent.errors[:payment].any?).to eq(true)
	  end
  end

  it "rejects invalid notes" do
  	details = [ "<>" , "@£$£$£@%^&^^&^(()"]
  	details.each do |detail|
      rent = Rent.new(notes: detail)
      rent.valid?
      expect(rent.errors[:notes].any?).to eq(true)
    end
  end
end