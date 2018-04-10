require 'rails_helper'

RSpec.describe Maintenance do 

  let(:maintenance){build_stubbed(:maintenance)}
	
	it "is valid with example attributes" do
    expect(maintenance.valid?).to eq(true)
  end

  it "requires a cost" do
    maintenance.cost = ""
    maintenance.valid?  
    expect(maintenance.errors[:cost].any?).to eq(true)
  end

  it "rejects invalid cost values" do
  	costs = %w[-125.44 fiftyquid <> toomuch!]
  	costs.each do |cost|
      maintenance.cost = cost
      maintenance.valid?
      expect(maintenance.errors[:cost].any?).to eq(true)
    end
  end

  it "requires a details" do
    maintenance.details = ""
    maintenance.valid?  
    expect(maintenance.errors[:details].any?).to eq(true)
  end

  it "rejects invalid details" do
  	details = [ "<>" , "@£$£$£@%^&^^&^(()"]
  	details.each do |detail|
      maintenance.details = detail
      maintenance.valid?
      expect(maintenance.errors[:details].any?).to eq(true)
    end
  end

  it "requires a date" do
    maintenance.date =  nil
    maintenance.valid?
    expect(maintenance.errors[:date].any?).to eq(true)
  end
end