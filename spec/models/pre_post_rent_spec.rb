require 'rails_helper'

RSpec.describe 'pre_post_rent' do

	context 'rent due' do
		it "calculates correct rent due before rent change date" do
			property = create(:property, rent_period_start:28.days.ago, first_day_of_next_rent_period: 14.days.ago, new_rent_value:140)
			expect(property.rent_due_before(property.rent_per_week, property.rent_period_start, property.first_day_of_next_rent_period).to_s).to eq("140.0")
		end

		it "calculates the rent due on or after rent change date" do
			property = create(:property, rent_period_start:28.days.ago, first_day_of_next_rent_period: 14.days.ago, new_rent_value:140)
			expect(property.rent_due_on_to_including(property.new_rent_value, property.first_day_of_next_rent_period, Time.now.to_date).to_s).to eq("300.0")
		end
	end

	context 'payments made' do
		it "adds up the payments before rent change date" do
			property = create(:property, rent_period_start:28.days.ago, first_day_of_next_rent_period: 14.days.ago, new_rent_value:140)
			property.rents.create(date:28.days.ago,payment:70)
			property.rents.create(date:21.days.ago,payment:70)
			expect(property.rent_paid_on_to_day_before(property.rent_period_start, property.first_day_of_next_rent_period).to_s).to eq("140.0")
		end

		it "adds up the payments on or after rent change date" do
			property = create(:property, rent_period_start:28.days.ago, first_day_of_next_rent_period: 14.days.ago, new_rent_value:140)
			property.rents.create(date:14.days.ago,payment:140)
			property.rents.create(date:7.days.ago,payment:140)
			property.rents.create(date:1.days.ago,payment:140)
			expect(property.rent_paid_on_to_including(property.first_day_of_next_rent_period, Time.now.to_date).to_s).to eq("420.0")
		end

		it "adds up the payments before rent change date ignoring payments outside of dates" do
			property = create(:property, rent_period_start:28.days.ago, first_day_of_next_rent_period: 14.days.ago, new_rent_value:140)
			property.rents.create(date:200.days.ago,payment:70)
			property.rents.create(date:100.days.ago,payment:70)
			property.rents.create(date:28.days.ago,payment:70)
			property.rents.create(date:21.days.ago,payment:70)
			expect(property.rent_paid_on_to_day_before(property.rent_period_start, property.first_day_of_next_rent_period).to_s).to eq("140.0")
		end

		it "adds up the payments on or after rent change date ignoring payments outside of dates" do
			property = create(:property, rent_period_start:28.days.ago, first_day_of_next_rent_period: 14.days.ago, new_rent_value:140)
			property.rents.create(date:70.days.ago,payment:140)
			property.rents.create(date:77.days.ago,payment:140)
			expect(property.rent_paid_on_to_including(property.first_day_of_next_rent_period, Time.now.to_date		).to_s).to eq("0")
		end
	end

	context 'rent balance' do
		it 'updates the rent balance figure at the end of the rent period' do
			property = create(:property, rent_period_start:28.days.ago, first_day_of_next_rent_period: 14.days.ago, new_rent_value:140, rent_balance: 0)
			property.rents.create(date:28.days.ago,payment:70)
			property.pre_post_rent
			expect(property.rent_balance.to_s).to eq("-70.0")
		end

		it 'updates the rent balance figure at the end of the rent period adding the new to the old (negative)' do
			property = create(:property, rent_period_start:28.days.ago, first_day_of_next_rent_period: 14.days.ago, new_rent_value:140, rent_balance:-100.0)
			property.rents.create(date:28.days.ago,payment:70)
			property.pre_post_rent
			expect(property.rent_balance.to_s).to eq("-170.0")
		end

		it 'updates the rent balance figure at the end of the rent period adding the new to the old (positive)' do
			property = create(:property, rent_period_start:28.days.ago, first_day_of_next_rent_period: 14.days.ago, new_rent_value:140, rent_balance:70.0)
			property.rents.create(date:28.days.ago,payment:70)
			property.pre_post_rent
			expect(property.rent_balance.to_s).to eq("0.0")
		end
	end

	context 'balance_created' do
		it 'updates balance_created date only once' do
			property = create(:property, rent_period_start:28.days.ago, first_day_of_next_rent_period: 14.days.ago, new_rent_value:140, rent_balance:0, balance_created:nil)
			property.rents.create(date:28.days.ago,payment:140)
			property.pre_post_rent
			expect(property.balance_created).not_to eq(nil)
		end
	end

	context 'rent position' do
		it "calculates the correct rent position with no previous rent balance" do
			property = create(:property, rent_period_start:28.days.ago, first_day_of_next_rent_period:14.days.ago, new_rent_value:140)
			property.rents.create(date:28.days.ago,payment:70)
			property.rents.create(date:21.days.ago,payment:70)
			property.rents.create(date:14.days.ago,payment:140)
			property.rents.create(date:7.days.ago,payment:140)
			property.rents.create(date:Time.now.to_date,payment:20)
			expect(property.pre_post_rent.to_s).to eq("0.0")
		end

		it "calculates the correct rent position carrying over a positive rent balance" do
			property = create(:property, rent_period_start:28.days.ago, first_day_of_next_rent_period:14.days.ago, rent_balance:100.0, new_rent_value:140)
			property.rents.create(date:28.days.ago,payment:70)
			property.rents.create(date:21.days.ago,payment:70)
			property.rents.create(date:14.days.ago,payment:140)
			property.rents.create(date:7.days.ago,payment:140)
			property.rents.create(date:Time.now.to_date,payment:20)
			expect(property.rent_balance.to_s).to eq("100.0")
			expect(property.pre_post_rent.to_s).to eq("100.0")
		end

		it "calculates the correct rent position carrying over a negative rent balance" do
			property = create(:property, rent_period_start:28.days.ago, first_day_of_next_rent_period:14.days.ago, rent_balance:-100.0, new_rent_value:140)
			property.rents.create(date:28.days.ago,payment:70)
			property.rents.create(date:21.days.ago,payment:70)
			property.rents.create(date:14.days.ago,payment:140)
			property.rents.create(date:7.days.ago,payment:140)
			property.rents.create(date:Time.now.to_date,payment:20)
			expect(property.pre_post_rent.to_s).to eq("-100.0")
		end
	end
end
