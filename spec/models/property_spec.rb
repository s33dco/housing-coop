require 'rails_helper'

describe 'a property' do

	it "is valid with example attributes" do
    property = Property.new(property_attributes)
    
    expect(property.valid?).to eq(true)
  end

  it "requires a house name or number" do
    property = Property.new(house_name_no: "")

    property.valid?

    expect(property.errors[:house_name_no].any?).to eq(true)
  end

  it "rejects a house name or number with non alphnumerics" do

  	tests = %w[23? <!> (MYHOUSE) #fortytwo]
  	tests.each do |test|
      property = Property.new(house_name_no: test)
      property.valid?
      
      expect(property.errors[:house_name_no].any?).to eq(true)
    end
  end


  it "requires street name" do
    property = Property.new(address1: "")

    property.valid?

    expect(property.errors[:address1].any?).to eq(true)
  end

  it "rejects a street name with non alphnumerics" do

  	tests = %w[23? <!> (MYHOUSEst) #fortytwoAvenue]
  	tests.each do |test|
      property = Property.new(address1: test)
      property.valid?
      
      expect(property.errors[:address1].any?).to eq(true)
    end
  end

  it "requires town or city" do
    property = Property.new(address2: "")

    property.valid?

    expect(property.errors[:address2].any?).to eq(true)
  end

  it "rejects a street name with non alphnumerics" do

  	tests = %w[23? <!> (MYHOUSEst) #fortytwoAvenue]
  	tests.each do |test|
      property = Property.new(address2: test)
      property.valid?
      
      expect(property.errors[:address2].any?).to eq(true)
    end
  end

  it "requires a postcode" do
    property = Property.new(postcode: "")

    property.valid?

    expect(property.errors[:postcode].any?).to eq(true)
  end

  it "accepts a valid postcode" do
  	tests = ["wc1h 0aa", "da17 5ag", "b1 1ay", "g3 7uw", "BT33 0AA"]
  	tests.each do |test|
      property = Property.new(postcode: test)
      property.valid?
      
      expect(property.errors[:postcode].any?).to eq(false)
    end
  end

  it "rejects an invalid postcode" do
  	tests = ["wc1hh 99jh", "b! 7HG", "<><> **&", "postcode", "JJ99j HHH"]
  	tests.each do |test|
      property = Property.new(postcode: test)
      property.valid?
      
      expect(property.errors[:postcode].any?).to eq(true)
    end
  end

  it "requires a rent per week value" do
    property = Property.new(rent_per_week: "")

    property.valid?

    expect(property.errors[:rent_per_week].any?).to eq(true)
  end

  it "rejects invalid rent values" do
  	rents = %w[-125.44 fiftyquid <> toomuch!]
  	rents.each do |rent|
      property = Property.new(rent_per_week: rent)
      property.valid?
      
      expect(property.errors[:rent_per_week].any?).to eq(true)
    end
  end
end