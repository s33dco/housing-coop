require 'rails_helper'

describe 'a maintenance record' do 
	
	it "is valid with example attributes" do
		property = Property.create!(property_attributes)
    worktype = Worktype.create!(worktype_attributes)
		contractor = Contractor.create!(contractor_attributes)
    maintenance = Maintenance.new(maintenance_attributes)
    maintenance.property = property
		maintenance.contractor = contractor
    maintenance.worktype = worktype
    
    expect(maintenance.valid?).to eq(true)
  end

  it "requires a cost" do
    maintenance = Maintenance.new(cost: "")
    maintenance.valid?  
    expect(maintenance.errors[:cost].any?).to eq(true)
  end


  it "rejects invalid cost values" do
  	costs = %w[-125.44 fiftyquid <> toomuch!]
  	costs.each do |cost|
      maintenance = Maintenance.new(cost: cost)
      maintenance.valid?
      expect(maintenance.errors[:cost].any?).to eq(true)
    end
  end

  it "requires a details" do
    maintenance = Maintenance.new(details: "")
    maintenance.valid?  
    expect(maintenance.errors[:details].any?).to eq(true)
  end

  it "rejects invalid details" do
  	details = [ "<>" , "@£$£$£@%^&^^&^(()"]
  	details.each do |detail|
      maintenance = Maintenance.new(details: detail)
      maintenance.valid?
      expect(maintenance.errors[:details].any?).to eq(true)
    end
  end


end