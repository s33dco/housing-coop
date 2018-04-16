require 'rails_helper'

RSpec.describe 'Rent Balance' do

	it 'identifies when a property is vacant by date combinations set' do
		property = build_stubbed(:property, rent_period_start:nil, first_day_of_next_rent_period:nil, moving_out_date:1.day.ago)
		expect(property.vacant?).to eq(true)
		expect(property.standard_process?).to eq(false)
		expect(property.rent_change_period?).to eq(false)
	end 

	it 'identifies when a property is not vacant by date combinations set' do
		property = build_stubbed(:property, rent_period_start:4.months.ago, first_day_of_next_rent_period:2.months.ago, moving_out_date:2.months.from_now)
		expect(property.vacant?).to eq(false)
		expect(property.standard_process?).to eq(false)
		expect(property.rent_change_period?).to eq(true)
	end 

	it 'identifies when a property is not vacant if moving out date nil' do
		property = build_stubbed(:property, rent_period_start:4.months.ago, first_day_of_next_rent_period:nil, moving_out_date:nil)
		expect(property.standard_process?).to eq(true)
		expect(property.vacant?).to eq(false)
		expect(property.rent_change_period?).to eq(false)
	end 

	it 'identifies standard rent process by date combinations(rent_period_start only)' do
		property = build_stubbed(:property, rent_period_start:4.months.ago, first_day_of_next_rent_period:nil, moving_out_date:nil)
		expect(property.standard_process?).to eq(true)
		expect(property.vacant?).to eq(false)
		expect(property.rent_change_period?).to eq(false)
	end 

	it 'identifies standard rent process by date combinations(rent_period_start & first_day_of_next_rent_period only)' do
		property = build_stubbed(:property, rent_period_start:4.months.ago, first_day_of_next_rent_period:1.month.from_now, moving_out_date:nil)
		expect(property.standard_process?).to eq(true)
		expect(property.vacant?).to eq(false)
		expect(property.rent_change_period?).to eq(false)
	end 

	it 'identifies standard rent process by date combinations(all dates)' do
		property = build_stubbed(:property, rent_period_start:4.months.ago, first_day_of_next_rent_period:1.year.from_now, moving_out_date:2.years.from_now)
		expect(property.standard_process?).to eq(true)
		expect(property.vacant?).to eq(false)
		expect(property.rent_change_period?).to eq(false)
	end 

	it 'identifies rent change period by date combinations(all dates)' do
		property = build_stubbed(:property, rent_period_start:4.months.ago, first_day_of_next_rent_period:Time.now.to_date, moving_out_date:2.years.from_now)
		expect(property.rent_change_period?).to eq(true)
		expect(property.standard_process?).to eq(false)
		expect(property.vacant?).to eq(false)
	end 

	it 'identifies rent change period by date combinations(all dates)' do
		property = build_stubbed(:property, rent_period_start:4.months.ago, first_day_of_next_rent_period:1.day.ago, moving_out_date:2.years.from_now)
		expect(property.rent_change_period?).to eq(true)
		expect(property.standard_process?).to eq(false)
		expect(property.vacant?).to eq(false)
	end 

	it 'identifies rent change period by date combinations(all dates)' do
		property = build_stubbed(:property, rent_period_start:4.months.ago, first_day_of_next_rent_period:Time.now.to_date, moving_out_date:nil)
		expect(property.rent_change_period?).to eq(true)
		expect(property.standard_process?).to eq(false)
		expect(property.vacant?).to eq(false)
	end 

	it 'identifies when not a rent change period by date combinations' do
		property = build_stubbed(:property, rent_period_start:4.months.ago, first_day_of_next_rent_period:2.days.from_now, moving_out_date:nil)
		expect(property.rent_change_period?).to eq(false)
		expect(property.standard_process?).to eq(true)
		expect(property.vacant?).to eq(false)
	end 

	it 'identifies when rent change after moving_out_date'do
		property = build_stubbed(:property, rent_period_start:6.months.ago, first_day_of_next_rent_period:1.week.ago, moving_out_date:5.weeks.ago)
		expect(property.no_rent_increase?).to eq(false)
		expect(property.vacant?).to eq(true)
		expect(property.standard_process?).to eq(false)
		expect(property.rent_change_period?).to eq(false)
	end 
end