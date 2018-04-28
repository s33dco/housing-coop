require 'rails_helper'

RSpec.describe 'Rent Balance' do
	context 'test vacant?' do
		it 'identifies when a property is vacant by date combinations set(1)' do
			property = build_stubbed(:property, rent_period_start:nil, first_day_of_next_rent_period:nil, moving_out_date:1.day.ago)
			expect(property.vacant?).to eq(true)
			expect(property.rent_change_period?).to eq(false)
		end 

		it 'identifies when a property is vacant by date combinations set(2)' do
			property = build_stubbed(:property, rent_period_start:nil, first_day_of_next_rent_period:nil, moving_out_date:Time.now.to_date)
			expect(property.vacant?).to eq(false)
			expect(property.rent_change_period?).to eq(false)
		end

		it 'identifies when a property is vacant by date combinations set(3)' do
			property = build_stubbed(:property, rent_period_start:10.weeks.ago, first_day_of_next_rent_period:nil, moving_out_date:2.weeks.ago)
			expect(property.vacant?).to eq(true)
			expect(property.rent_change_period?).to eq(false)
		end 

		it 'identifies when a property is vacant by date combinations set(4)' do
			property = build_stubbed(:property, rent_period_start:nil, first_day_of_next_rent_period:3.weeks.ago, moving_out_date:5.weeks.ago)
			expect(property.vacant?).to eq(true)
			expect(property.rent_change_period?).to eq(false)
		end 

		it 'identifies when a property is not vacant by date combinations(1)' do
			property = build_stubbed(:property, rent_period_start:4.months.ago, first_day_of_next_rent_period:2.months.ago, moving_out_date:2.months.from_now)
			expect(property.vacant?).to eq(false)
			expect(property.rent_change_period?).to eq(true)
		end 

		it 'identifies when a property is not vacant by date combinations(2)' do
			property = build_stubbed(:property, rent_period_start:4.months.ago, first_day_of_next_rent_period:nil, moving_out_date:nil)
			expect(property.vacant?).to eq(false)
			expect(property.rent_change_period?).to eq(false)
		end

		it 'identifies when a property is not vacant by date combinations(3)' do
			property = build_stubbed(:property, rent_period_start:4.months.ago, first_day_of_next_rent_period:nil, moving_out_date:nil)
			expect(property.vacant?).to eq(false)
			expect(property.rent_change_period?).to eq(false)
		end

		it 'identifies when a property is not vacant by date combinations(4)' do
			property = build_stubbed(:property, rent_period_start:nil, first_day_of_next_rent_period:8.weeks.ago, moving_out_date:Time.now.to_date)
			expect(property.vacant?).to eq(false)
			expect(property.rent_change_period?).to eq(true)
		end
	end 

	context 'test rent_change_period?' do
		it 'identifies rent change period by date combinations(1)' do
			property = build_stubbed(:property, rent_period_start:4.months.ago, first_day_of_next_rent_period:Time.now.to_date, moving_out_date:2.years.from_now)
			expect(property.rent_change_period?).to eq(true)
			expect(property.vacant?).to eq(false)
		end 

		it 'identifies rent change period by date combinations(2)' do
			property = build_stubbed(:property, rent_period_start:4.months.ago, first_day_of_next_rent_period:1.day.ago, moving_out_date:2.years.from_now)
			expect(property.rent_change_period?).to eq(true)
			expect(property.vacant?).to eq(false)
		end 

		it 'identifies rent change period by date combinations(3)' do
			property = build_stubbed(:property, rent_period_start:4.months.ago, first_day_of_next_rent_period:Time.now.to_date, moving_out_date:nil)
			expect(property.rent_change_period?).to eq(true)
			expect(property.vacant?).to eq(false)
		end 

		it 'identifies when not a rent change period by date combinations(1)' do
			property = build_stubbed(:property, rent_period_start:4.months.ago, first_day_of_next_rent_period:2.days.from_now, moving_out_date:nil)
			expect(property.rent_change_period?).to eq(false)
			expect(property.vacant?).to eq(false)
		end 

		it 'identifies when not a rent change period by date combinations(2)'do
			property = build_stubbed(:property, rent_period_start:10.weeks.ago, first_day_of_next_rent_period:1.week.ago, moving_out_date:5.weeks.ago)
			expect(property.rent_increase_whilst_vacant?).to eq(true)
			expect(property.vacant?).to eq(true)
			expect(property.rent_change_period?).to eq(false)
		end
	end 

	context 'test scenarios only fire standard rent' do
		it 'identifies when not a rent change period && not vacant by date combinations(1)' do
			property = build_stubbed(:property, rent_period_start:4.months.ago, first_day_of_next_rent_period:nil, moving_out_date:nil)
			expect(property.rent_change_period?).to eq(false)
			expect(property.vacant?).to eq(false)
		end

		it 'identifies when not a rent change period && not vacant by date combinations(2)' do
			property = build_stubbed(:property, rent_period_start:4.months.ago, first_day_of_next_rent_period:nil, moving_out_date:7.weeks.from_now)
			expect(property.rent_change_period?).to eq(false)
			expect(property.vacant?).to eq(false)
		end

		it 'identifies when not a rent change period && not vacant by date combinations(3)' do
			property = build_stubbed(:property, rent_period_start:4.months.ago, first_day_of_next_rent_period:1.day.from_now, moving_out_date:7.weeks.from_now)
			expect(property.rent_change_period?).to eq(false)
			expect(property.vacant?).to eq(false)
		end

		it 'identifies when not a rent change period && not vacant by date combinations(4)' do
			property = build_stubbed(:property, rent_period_start:4.months.ago, first_day_of_next_rent_period:1.day.from_now, moving_out_date:nil)
			expect(property.rent_change_period?).to eq(false)
			expect(property.vacant?).to eq(false)
		end
	end
end