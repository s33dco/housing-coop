require 'rails_helper'

RSpec.describe Calendar do 

	let(:event){build_stubbed(:calendar)}

	it "is valid with example attributes" do
    expect(event.valid?).to eq(true)
  end 

  it "requires a date and time" do
    event.date_time = ""
    event.valid?
    expect(event.errors[:date_time].any?).to eq(true)
  end

  it "requires a title" do
    event.title = ""
    event.valid?
    expect(event.errors[:title].any?).to eq(true)
  end

  it "rejects improperly formatted titles" do
	names = [ "!ks<>", " ", "1-2-2!!!#"]
	names.each do |name|
	    event.title = name
	    event.valid?
    	expect(event.errors[:title].any?).to eq(true)
    end
  end

  it "requires a where" do
    event.where = ""
    event.valid?
    expect(event.errors[:where].any?).to eq(true)
  end

  it "rejects improperly formatted wheres" do
	names = [ "!ks<>", " ", "1-2-2!!!#$%"]
	names.each do |name|
	    event.where= name
	    event.valid?
    	expect(event.errors[:where].any?).to eq(true)
    end
  end

  it "requires details" do
    event.details= ""
    event.valid?
    expect(event.errors[:details].any?).to eq(true)
  end

  it "rejects improperly formatted details" do
	names = [ "!ks<>", " ", "1-2-2!!!$@%&*"]
	names.each do |name|
	    event.details= name
	    event.valid?
    	expect(event.errors[:details].any?).to eq(true)
    end
	end
end