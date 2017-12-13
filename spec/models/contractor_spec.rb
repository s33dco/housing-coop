require 'rails_helper'

describe 'a contractor' do 

	it "is valid with example attributes" do
		contractor = Contractor.new(contractor_attributes)
    expect(contractor.valid?).to eq(true)
  end

  it "requires a name" do
    contractor = Contractor.new(name: "")
    contractor.valid?
    expect(contractor.errors[:name].any?).to eq(true)
  end

  it "accepts properly formatted names" do
  	names = [ "Steve", "Del", "Franky", "Mister Friendly Plumber", "The acme Plumbing Corporation"]
  	names.each do |name|
	    contractor = Contractor.new(name: name)
	    contractor.valid?
    	expect(contractor.errors[:name].any?).to eq(false)
    end
  end

  it "rejects improperly formatted names" do
  	names = [ "!ks<>", " ", "1-2-2!!!"]
  	names.each do |name|
	    contractor = Contractor.new(name: name)
	    contractor.valid?
    	expect(contractor.errors[:name].any?).to eq(true)
    end
  end

  it "requires an email" do
    contractor = Contractor.new(email: "")

    contractor.valid?

    expect(contractor.errors[:email].any?).to eq(true)
  end

  it "accepts properly formatted email addresses" do
    emails = %w[user@example.com first.last@example.com to@bee.co]
    emails.each do |email|
      contractor = Contractor.new(email: email)
      contractor.valid?
      expect(contractor.errors[:email].any?).to eq(false)
    end
  end

  it "rejects improperly formatted email addresses" do
    emails = %w[@ user@ @example.com]
    emails.each do |email|
      contractor = Contractor.new(email: email)
      contractor.valid?
      expect(contractor.errors[:email].any?).to eq(true)
    end
  end

  it "requires some details" do
    contractor = Contractor.new(details: "")

    contractor.valid?

    expect(contractor.errors[:details].any?).to eq(true)
  end

  it "accepts properly formatted details" do
  	details = [ "plumbing and odd-jobs", "general repairs and carpentry", "electrics and hot water", "he's the best electrician in the univese"]
  	details.each do |detail|
	    contractor = Contractor.new(details: detail)
	    contractor.valid?
    	expect(contractor.errors[:details].any?).to eq(false)
    end
  end

  it "rejects improperly formatted details" do
  	details = [ "!ks<>", " ", "1-2-2!!!"]
  	details.each do |detail|
	    contractor = Contractor.new(details: detail)
	    contractor.valid?
    	expect(contractor.errors[:details].any?).to eq(true)
    end
  end

end