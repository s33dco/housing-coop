require 'rails_helper'

RSpec.describe 'standard_rent' do

	it 'resets balance_created field' do
		property = create(:property, rent_period_start:28.days.ago, balance_created: 14.days.ago)
		property.standard_rent
		expect(property.balance_created).to eq(nil)
	end

	context 'rent due' do
		it "calculates the rent due from the moving in date(rent_period_start)" do
			property = build_stubbed(:property, rent_period_start:28.days.ago)
			expect(property.rent_due_on_to_including(property.rent_per_week,property.rent_period_start, Time.now.to_date).to_s).to eq("290.0")
		end

		it "calculates the rent due when an increase date set in the future" do
			property = build_stubbed(:property, rent_period_start:28.days.ago,first_day_of_next_rent_period:28.days.from_now )
			expect(property.rent_due_on_to_including(property.rent_per_week,property.rent_period_start, Time.now.to_date).to_s).to eq("290.0")
		end
	end

	context 'payments made' do
		it "adds the rent paid from the moving in date(rent_period_start) until now" do
			property = create(:property, rent_period_start:28.days.ago)
			property.rents.create(date:28.days.ago,payment:70)
			property.rents.create(date:21.days.ago,payment:70)
			property.rents.create(date:14.days.ago,payment:70)
			property.rents.create(date:7.days.ago,payment:70)
			property.rents.create(date:Time.now.to_date,payment:100)
			expect(property.rent_paid_on_to_including(property.rent_period_start, Time.now.to_date).to_s).to eq("380.0")
		end

		it "ignores rent payments before start date" do
			property = create(:property, rent_period_start:28.days.ago, first_day_of_next_rent_period: 14.days.ago, new_rent_value:140)
			property.rents.create(date:70.days.ago,payment:140)
			property.rents.create(date:77.days.ago,payment:140)
			expect(property.rent_paid_on_to_including(property.rent_period_start, Time.now.to_date).to_s).to eq("0")
		end
	end

	context 'rent balance' do
		it 'does not change the rent balance' do
			property = create(:property, rent_period_start:28.days.ago, rent_balance:-100.0)
			property.standard_rent
			expect(property.rent_balance.to_s).to eq("-100.0")
		end
	end

	context 'rent position' do
		it "calculates the correct rent position with no previous rent balance" do
			property = create(:property, rent_period_start:28.days.ago)
			property.rents.create(date:28.days.ago,payment:70)
			property.rents.create(date:21.days.ago,payment:70)
			property.rents.create(date:14.days.ago,payment:70)
			property.rents.create(date:7.days.ago,payment:70)
			property.rents.create(date:Time.now.to_date,payment:10)
			expect(property.standard_rent.to_s).to eq("0.0")
		end

		it "calculates the correct rent position carrying over a positive rent balance" do
			property = create(:property, rent_period_start:28.days.ago, rent_balance:100.0)
			property.rents.create(date:28.days.ago,payment:70)
			property.rents.create(date:21.days.ago,payment:70)
			property.rents.create(date:14.days.ago,payment:70)
			property.rents.create(date:7.days.ago,payment:70)
			property.rents.create(date:Time.now.to_date,payment:10)
			expect(property.rent_balance.to_s).to eq("100.0")
			expect(property.standard_rent.to_s).to eq("100.0")
		end

		it "calculates the correct rent position carrying over a positive rent balance" do
			property = create(:property, rent_period_start:28.days.ago, rent_balance:-100.0)
			property.rents.create(date:28.days.ago,payment:70)
			property.rents.create(date:21.days.ago,payment:70)
			property.rents.create(date:14.days.ago,payment:70)
			property.rents.create(date:7.days.ago,payment:70)
			property.rents.create(date:Time.now.to_date,payment:10)
			expect(property.rent_balance.to_s).to eq("-100.0")
			expect(property.standard_rent.to_s).to eq("-100.0")
		end
	end
end
