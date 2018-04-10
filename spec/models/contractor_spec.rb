require 'rails_helper'

RSpec.describe Contractor do 

  let(:contractor){build_stubbed(:contractor)}

	it "is valid with example attributes" do
    expect(contractor.valid?).to eq(true)
  end

  it "requires a name" do
    contractor.name = ""
    contractor.valid?
    expect(contractor.errors[:name].any?).to eq(true)
  end

  it "accepts properly formatted names" do
  	names = [ "Steve", "Del", "Franky", "Mister Friendly Plumber", "The acme Plumbing Corporation"]
  	names.each do |name|
	    contractor.name = name
	    contractor.valid?
    	expect(contractor.errors[:name].any?).to eq(false)
    end
  end

  it "rejects improperly formatted names" do
  	names = [ "!ks<>", " ", "1-2-2!!!"]
  	names.each do |name|
	    contractor.name = name
	    contractor.valid?
    	expect(contractor.errors[:name].any?).to eq(true)
    end
  end

  it "accepts properly formatted email addresses" do
    emails = %w[user@example.com first.last@example.com to@bee.co]
    emails.each do |email|
      contractor.email = email
      contractor.valid?
      expect(contractor.errors[:email].any?).to eq(false)
    end
  end

  it "rejects improperly formatted email addresses" do
    emails = %w[@ user@ @example.com]
    emails.each do |email|
      contractor.email = email
      contractor.valid?
      expect(contractor.errors[:email].any?).to eq(true)
    end
  end

  it "accepts properly formatted details" do
  	details = [ "plumbing and odd-jobs", "general repairs and carpentry", "electrics and hot water", "he's the best electrician in the univese"]
  	details.each do |detail|
	    contractor.details = detail
	    contractor.valid?
    	expect(contractor.errors[:details].any?).to eq(false)
    end
  end

  it "rejects improperly formatted details" do
  	details = [ "!ks<>", "1-2-2!!!"]
  	details.each do |detail|
	    contractor.details = detail
	    contractor.valid?
    	expect(contractor.errors[:details].any?).to eq(true)
    end
  end
end