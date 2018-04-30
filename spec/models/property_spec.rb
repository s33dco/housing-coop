

require 'rails_helper'

RSpec.describe Property do

  let(:property){build_stubbed(:property)}

	it "is valid with example attributes" do
    expect(property.valid?).to eq(true)
  end

  it "requires a house name or number" do
    property.name_or_number =  ""
    property.valid?
    expect(property.errors[:name_or_number].any?).to eq(true)
  end

  it "rejects a house name or number with non alphnumerics" do
  	tests = %w[23? <!> #fortytwo]
  	tests.each do |test|
      property.name_or_number = test
      property.valid?
      expect(property.errors[:name_or_number].any?).to eq(true)
    end
  end

  it "requires street name" do
    property.address1 = ""
    property.valid?
    expect(property.errors[:address1].any?).to eq(true)
  end

  it "rejects a street name with non alphnumerics" do
  	tests = %w[23? <!> #fortytwoAvenue]
  	tests.each do |test|
      property.address1 = test
      property.valid?
      expect(property.errors[:address1].any?).to eq(true)
    end
  end

  it "requires town or city" do
    property.address2 = ""
    property.valid?
    expect(property.errors[:address2].any?).to eq(true)
  end

  it "rejects a city name with non alphnumerics" do
  	tests = %w[23? <!> #fortytwoAvenue]
  	tests.each do |test|
      property.address2 = test
      property.valid?
      expect(property.errors[:address2].any?).to eq(true)
    end
  end

  it "requires a postcode" do
    property.postcode = ""
    property.valid?
    expect(property.errors[:postcode].any?).to eq(true)
  end

  it "accepts a valid postcode" do
  	tests = ["wc1h 0aa", "da17 5ag", "b1 1ay", "g3 7uw", "BT33 0AA"]
  	tests.each do |test|
      property.postcode = test
      property.valid?
      expect(property.errors[:postcode].any?).to eq(false)
    end
  end

  it "rejects an invalid postcode" do
  	tests = ["wc1hh 99jh", "b! 7HG", "<><> **&", "postcode", "JJ99j HHH"]
  	tests.each do |test|
      property.postcode = test
      property.valid?
      expect(property.errors[:postcode].any?).to eq(true)
    end
  end

  it "requires a rent per week value" do
    property.rent_per_week = ""
    property.valid?
    expect(property.errors[:rent_per_week].any?).to eq(true)
  end

  it "rejects invalid rent values" do
  	rents = %w[-125.44 fiftyquid <> toomuch!]
  	rents.each do |rent|
      property.rent_per_week = rent
      property.valid?
      expect(property.errors[:rent_per_week].any?).to eq(true)
    end
  end

  it "can have just a rent_period_start date" do
      property.moving_out_date = " "
      property.rent_period_start = 4.weeks.ago
      property.first_day_of_next_rent_period = " " 
      expect(property.valid?).to eq(true)
  end

  it "can have just a moving_out_date date" do
      property.moving_out_date = 4.weeks.ago
      property.rent_period_start = "" 
      property.first_day_of_next_rent_period = ""
      expect(property.valid?).to eq(true)
  end

  it "rent_period_start and moving_out_date both cannot be blank" do
      property.moving_out_date = ""
      property.rent_period_start = "" 
      property.first_day_of_next_rent_period = ""
      expect(property.valid?).to eq(false)
  end

  it "rejects a moving_out_date earlier rent_period_start" do
      property.moving_out_date = 4.weeks.ago
      property.rent_period_start = 2.weeks.ago
      expect(property.valid?).to eq(false)
  end

  it "accepts a moving_out_date after rent_period_start" do
      property.moving_out_date = 2.weeks.ago
      property.rent_period_start = 4.weeks.ago
      expect(property.valid?).to eq(true)
  end

  it "rejects a future moving_out_date if no rent_period_start" do
      property.moving_out_date = 4.weeks.from_now
      property.rent_period_start = nil
      expect(property.valid?).to eq(false)
  end

  it "accepts a moving_out_date in the past and no rent period start" do
      property.moving_out_date = 2.weeks.ago
      property.rent_period_start = nil
      expect(property.valid?).to eq(true)
  end

  it "rejects a nil new rent value if first_day_of_next_rent_period set" do
      property.new_rent_value = ''
      property.first_day_of_next_rent_period = 2.weeks.from_now
      expect(property.valid?).to eq(false)
  end

  it "first_day_of_next_rent_period can be later than rent period start" do
      property.rent_period_start = 2.weeks.from_now
      property.first_day_of_next_rent_period = 5.weeks.from_now
      expect(property.valid?).to eq(true)
  end

  it "first_day_of_next_rent_period can't be earlier than rent period start" do
      property.rent_period_start = 5.weeks.from_now
      property.first_day_of_next_rent_period = 2.weeks.from_now
      expect(property.valid?).to eq(false)
  end
end
