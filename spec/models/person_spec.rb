require 'rails_helper'

describe 'a person' do 

	it "is valid with example attributes" do
		property = Property.new(property_attributes)
    person = Person.new(person_attributes)
    person.property = property
    
    expect(person.valid?).to eq(true)
  end

  it "requires a first name" do
    person = Person.new(person_attributes(firstname: ""))

    person.valid?

    expect(person.errors[:firstname].any?).to eq(true)
  end

  it "rejects an improperly formatted first name" do
    names = %w[1 <> st3v3 dav1d]
    names.each do |name|
      person = Person.new(person_attributes(firstname: name))
      person.valid?
      
      expect(person.errors[:firstname].any?).to eq(true)
    end
  end

  it "requires a last name" do
    person = Person.new(person_attributes(lastname: ""))

    person.valid?

    expect(person.errors[:lastname].any?).to eq(true)
  end

  it "rejects an improperly formatted last name" do
    names = %w[1 a <> st3v3 dav1d]
    names.each do |name|
      person = Person.new(person_attributes(lastname: name))
      person.valid?
      
      expect(person.errors[:lastname].any?).to eq(true)
    end
  end

  it "requires an email" do
    person = Person.new(person_attributes(email: ""))

    person.valid?

    expect(person.errors[:email].any?).to eq(true)
  end

  it "accepts properly formatted email addresses" do
    emails = %w[user@example.com first.last@example.com to@bee.co]
    emails.each do |email|
      person = Person.new(person_attributes(email: email))
      person.valid?
      
      expect(person.errors[:email].any?).to eq(false)
    end
  end

  it "rejects improperly formatted email addresses" do
    emails = %w[@ user@ @example.com]
    emails.each do |email|
      person = Person.new(person_attributes(email: email))
      person.valid?
      
      expect(person.errors[:email].any?).to eq(true)
    end
  end

  it "requires a unique, case insensitive email address" do
		property = Property.new(property_attributes)

    person1 = Person.new(person_attributes)
		person1.property = property
		person1.save
    
    person2 = Person.new(person_attributes(email: person1.email.upcase))
    person2.property = property
    
    person2.valid?
    
    expect(person2.errors[:email].first).to eq("Email address already in use")
  end

  it "rejects incorrect phone numbers" do
    phones = %w[1 0121 123456 004401234567898 01278678678ext123 ]
    phones.each do |phone|
      person = Person.new(person_attributes(phone: phone))
      person.valid?
      
      expect(person.errors[:phone].any?).to eq(true)
    end
  end
end