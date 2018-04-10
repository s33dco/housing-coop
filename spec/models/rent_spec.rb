require 'rails_helper'

RSpec.describe Rent do

	let(:rent){build_stubbed(:rent)}

	it "is valid with example attributes" do
		expect(rent.valid?).to eq(true)
	end

	it "requires a house" do
	  rent.property =  nil
	  rent.valid?
	  expect(rent.errors[:property].any?).to eq(true)
	end

	it "requires a payment" do
	  rent.payment =  nil
	  rent.valid?
	  expect(rent.errors[:payment].any?).to eq(true)
	end

	it "accepts zero or positive values for payments" do
		payments = [ 0 , 1 , 1000000]
		payments.each do |payment |
			rent.payment = payment
		  rent.valid?
		  expect(rent.errors[:payment].any?).to eq(false)
		end
	end

	it "rejects negative payments" do
			payments = [ -10.11 , -1.01 , -10000.00]
			payments.each do |payment |
				rent.payment = payment
			  rent.valid?
			  expect(rent.errors[:payment].any?).to eq(true)
			end
		end

	it "requires a payment date" do
	  rent.date =  nil
	  rent.valid?
	  expect(rent.errors[:date].any?).to eq(true)
	end

end