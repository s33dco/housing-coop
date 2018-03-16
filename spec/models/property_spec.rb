require 'rails_helper'

describe 'a property' do

	it "is valid with example attributes" do
    property = Property.new(property_attributes)
    
    expect(property.valid?).to eq(true)
  end

  it "requires a house name or number" do
    property = Property.new(property_attributes(name_or_number: ""))

    property.valid?

    expect(property.errors[:name_or_number].any?).to eq(true)
  end

  it "rejects a house name or number with non alphnumerics" do

  	tests = %w[23? <!> #fortytwo]
  	tests.each do |test|
      property = Property.new(property_attributes(name_or_number: test))
      property.valid?
      
      expect(property.errors[:name_or_number].any?).to eq(true)
    end
  end


  it "requires street name" do
    property = Property.new(property_attributes(address1: ""))

    property.valid?

    expect(property.errors[:address1].any?).to eq(true)
  end

  it "rejects a street name with non alphnumerics" do

  	tests = %w[23? <!> #fortytwoAvenue]
  	tests.each do |test|
      property = Property.new(property_attributes(address1: test))
      property.valid?
      
      expect(property.errors[:address1].any?).to eq(true)
    end
  end

  it "requires town or city" do
    property = Property.new(property_attributes(address2: ""))

    property.valid?

    expect(property.errors[:address2].any?).to eq(true)
  end

  it "rejects a city name with non alphnumerics" do

  	tests = %w[23? <!> #fortytwoAvenue]
  	tests.each do |test|
      property = Property.new(property_attributes(address2: test))
      property.valid?
      
      expect(property.errors[:address2].any?).to eq(true)
    end
  end

  it "requires a postcode" do
    property = Property.new(property_attributes(postcode: ""))

    property.valid?

    expect(property.errors[:postcode].any?).to eq(true)
  end

  it "accepts a valid postcode" do
  	tests = ["wc1h 0aa", "da17 5ag", "b1 1ay", "g3 7uw", "BT33 0AA"]
  	tests.each do |test|
      property = Property.new(property_attributes(postcode: test))
      property.valid?
      
      expect(property.errors[:postcode].any?).to eq(false)
    end
  end

  it "rejects an invalid postcode" do
  	tests = ["wc1hh 99jh", "b! 7HG", "<><> **&", "postcode", "JJ99j HHH"]
  	tests.each do |test|
      property = Property.new(property_attributes(postcode: test))
      property.valid?
      
      expect(property.errors[:postcode].any?).to eq(true)
    end
  end

  it "requires a rent per week value" do
    property = Property.new(property_attributes(rent_per_week: ""))

    property.valid?

    expect(property.errors[:rent_per_week].any?).to eq(true)
  end

  it "rejects invalid rent values" do
  	rents = %w[-125.44 fiftyquid <> toomuch!]
  	rents.each do |rent|
      property = Property.new(property_attributes(rent_per_week: rent))
      property.valid?
      
      expect(property.errors[:rent_per_week].any?).to eq(true)
    end
  end

  it "last_day_of_rent_period must be set if rent_period_start is no set" do
      property = Property.new(property_attributes(last_day_of_rent_period: "", first_day_of_next_rent_period:""))
      property.valid?
      
      expect(property.errors[:last_day_of_rent_period].any?).to eq(true)
  end
end