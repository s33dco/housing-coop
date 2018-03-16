require 'rails_helper'

describe 'a calendar event' do 

		it "is valid with example attributes" do
			event = Calendar.new(calendar_attributes)
	    expect(event.valid?).to eq(true)
	  end 

	  it "requires a date and time" do
	    event = Calendar.new(calendar_attributes(date_time: ""))
	    event.valid?
	    expect(event.errors[:date_time].any?).to eq(true)
	  end

	  it "requires a title" do
	    event = Calendar.new(calendar_attributes(title: ""))
	    event.valid?
	    expect(event.errors[:title].any?).to eq(true)
	  end

	  it "rejects improperly formatted titles" do
  	names = [ "!ks<>", " ", "1-2-2!!!#"]
  	names.each do |name|
		    event = Calendar.new(calendar_attributes(title: name))
		    event.valid?
	    	expect(event.errors[:title].any?).to eq(true)
	    end
    end

	  it "requires a where" do
	    event = Calendar.new(calendar_attributes(where: ""))
	    event.valid?
	    expect(event.errors[:where].any?).to eq(true)
	  end

	  it "rejects improperly formatted wheres" do
  	names = [ "!ks<>", " ", "1-2-2!!!#$%"]
  	names.each do |name|
		    event = Calendar.new(calendar_attributes(where: name))
		    event.valid?
	    	expect(event.errors[:where].any?).to eq(true)
	    end
	  end

	  it "requires details" do
	    event = Calendar.new(calendar_attributes(details: ""))
	    event.valid?
	    expect(event.errors[:details].any?).to eq(true)
	  end

	  it "rejects improperly formatted details" do
  	names = [ "!ks<>", " ", "1-2-2!!!$@%&*"]
  	names.each do |name|
		    event = Calendar.new(calendar_attributes(details: name))
		    event.valid?
	    	expect(event.errors[:details].any?).to eq(true)
	    end
  	end
end