require 'rails_helper'

RSpec.describe Message, type: :model do

  it 'responds to name, email and body' do 
    msg = Message.new
    expect(msg).to respond_to(:name)
    expect(msg).to respond_to(:email)
    expect(msg).to respond_to(:body)
  end

  it 'should be valid with attributes' do 
  	message = build(:message)
    expect(message.valid?).to eq(true)
  end

  it "rejects improperly formatted email addresses" do
    emails = %w[@ user@ @example.com]
    emails.each do |address|
      message = build(:message, email: address)
      message.valid?
      expect(message.errors[:email].any?).to eq(true)
    end
  end

  it "rejects improperly formatted body" do
  	details = [ "!ks<>", "1-2-2!!!"]
  	details.each do |detail|
	    message = build(:message, body: detail)
	    message.valid?
    	expect(message.errors[:body].any?).to eq(true)
    end
  end

  it "rejects improperly formatted name" do
  	names = [ "!ks<>", "1-2-2!!!", "1", "?"]
  	names.each do |name|
	    message = build(:message, name: name)
	    message.valid?
    	expect(message.errors[:name].any?).to eq(true)
    end
  end
end
