require 'rails_helper'

RSpec.describe Person do 

  let(:person){build_stubbed(:person)}


  it "is valid with example attributes" do
   expect(person.valid?).to eq(true)
  end

  it "requires a first name" do
    person.firstname= ""
    person.valid?
    expect(person.errors[:firstname].any?).to eq(true)
  end

  it "rejects an improperly formatted first name" do
    names = %w[1 <> st3v3 dav1d]
    names.each do |name|
      person.firstname= ""
      person.valid?
      expect(person.errors[:firstname].any?).to eq(true)
    end
  end

  it "requires a last name" do
    person.lastname = ""
    person.valid?
    expect(person.errors[:lastname].any?).to eq(true)
  end

  it "rejects an improperly formatted last name" do
    names = %w[1 a <> st3v3 dav1d]
    names.each do |name|
      person.lastname = name
      person.valid?
      expect(person.errors[:lastname].any?).to eq(true)
    end
  end

  it "requires an email" do
    person.email= ""
    person.valid?
    expect(person.errors[:email].any?).to eq(true)
  end

  it "accepts properly formatted email addresses" do
    emails = %w[user@example.com first.last@example.com to@bee.co]
    emails.each do |email|
      person.email = email
      person.valid?
      expect(person.errors[:email].any?).to eq(false)
    end
  end

  it "rejects improperly formatted email addresses" do
    emails = %w[@ user@ @example.com]
    emails.each do |email|
      person.email = email
      person.valid?
      expect(person.errors[:email].any?).to eq(true)
    end
  end

  it "requires a unique, case insensitive email address" do
    persona = create(:person)
    personb = build(:person)
    personb.email = persona.email
    personb.save
    expect(personb.errors[:email].first).to eq("Email address already in use")
  end

  it "rejects incorrect phone numbers" do
    phones = %w[1 0121 123456 004401234567898 01278678678ext123 ]
    phones.each do |phone|
      person.phone = phone
      person.valid?
      expect(person.errors[:phone].any?).to eq(true)
    end
  end

  it "requires a password" do
    person3 = build(:person)
    person3.password=""
    person3.password_confirmation=""
    person3.save
    expect(person3.errors[:password].any?).to eq(true)
  end

  it "requires password and confirmation match" do
    person.password_confirmation=""
    person.valid?
    expect(person.errors[:password_confirmation].any?).to eq(true)
  end
end