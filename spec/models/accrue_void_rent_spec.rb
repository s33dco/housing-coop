require 'rails_helper'

RSpec.describe 'accrue_void_rent' do

	context 'recognizes rent increase after moving out date' do
		it 'recognizes a rent increase after moving out date' do
			property = create(:property, rent_period_start:28.days.ago, moving_out_date:14.days.ago, first_day_of_next_rent_period: 7.days.ago, new_rent_value:140)
			expect(property.rent_increase_whilst_vacant?).to eq(true)
		end

		it 'recognizes a rent increase after moving out date' do
			property = create(:property, rent_period_start:nil, moving_out_date:14.days.ago, first_day_of_next_rent_period: 7.days.ago, new_rent_value:140)
			expect(property.rent_increase_whilst_vacant?).to eq(true)
		end

		it 'recognizes a rent increase after moving out date' do
			property = create(:property, rent_period_start:nil, moving_out_date:7.days.ago, first_day_of_next_rent_period: 7.days.ago, new_rent_value:140)
			expect(property.rent_increase_whilst_vacant?).to eq(true)
		end

		it 'recognizes a rent increase after moving out date' do
			property = create(:property, rent_period_start:nil, moving_out_date:7.days.ago, first_day_of_next_rent_period: Time.now.to_date, new_rent_value:140)
			expect(property.rent_increase_whilst_vacant?).to eq(true)
		end
	end

	context 'recognizes when not a rent increase after moving out date' do	
		it 'a future rent increase' do
			 property = create(:property, rent_period_start:7.months.ago, moving_out_date:2.months.ago, first_day_of_next_rent_period: 7.days.from_now, new_rent_value:140)
			 expect(property.rent_increase_whilst_vacant?).to eq(false)
		end

		it 'a future rent increase' do
			 property = create(:property, rent_period_start:7.months.ago, moving_out_date:2.months.ago, first_day_of_next_rent_period: 7.days.from_now, new_rent_value:140)
			 expect(property.rent_increase_whilst_vacant?).to eq(false)
		end

		it 'a no increase' do
			 property = create(:property, rent_period_start:7.months.ago, moving_out_date:2.months.ago, first_day_of_next_rent_period: nil, new_rent_value:140)
			 expect(property.rent_increase_whilst_vacant?).to eq(false)
		end

		it 'a no rent period start, no increase' do
			 property = create(:property, rent_period_start:nil, moving_out_date:2.months.ago, first_day_of_next_rent_period: nil, new_rent_value:140)
			 expect(property.rent_increase_whilst_vacant?).to eq(false)
		end
	end

	context 'will update final balances' do
		it 'when no rent change after moved out' do
			property = create(:property, rent_period_start:28.days.ago, moving_out_date:14.days.ago, first_day_of_next_rent_period: nil, new_rent_value:nil, rent_balance:-100, end_of_tenancy_balance:nil, balance_created: nil)
			expect(property.make_final_balance).to eq(true)
			expect(property.rent_rise_before_final_balance?).to eq(false)
			expect(property.end_of_tenancy_balance.to_s).to eq("-250.0")
			expect(property.rent_balance.to_s).to eq("0.0")
			expect(property.balance_created).to eq(nil)
		end

		it 'when no rent change after moved out' do
			property = create(:property, rent_period_start:28.days.ago, moving_out_date:7.days.ago, first_day_of_next_rent_period: 14.days.ago, new_rent_value:140, rent_balance:-100, end_of_tenancy_balance:nil, balance_created: nil)
			expect(property.make_final_balance).to eq(true)
			expect(property.rent_rise_before_final_balance?).to eq(true)
			expect(property.end_of_tenancy_balance.to_s).to eq("-400.0")
			expect(property.rent_balance.to_s).to eq("0.0")
			expect(property.balance_created).to eq(nil)
		end
	end

	context 'totals up rent due whilst vacant' do
		it 'adds up rent with no change correctly' do
			property = create(:property, rent_period_start:28.days.ago, moving_out_date:14.days.ago, first_day_of_next_rent_period: nil)
			property.void_rent
			expect(property.rent_increase_whilst_vacant?).to eq(false)
			expect(property.void_rent.to_s).to eq("-140.0")
		end

		it 'adds up rent with a change correctly' do
			property = create(:property, rent_period_start:35.days.ago, moving_out_date:14.days.ago, first_day_of_next_rent_period: 7.days.ago, new_rent_value: 140)
			property.void_rent
			expect(property.rent_increase_whilst_vacant?).to eq(true)
			expect(property.void_rent.to_s).to eq("-230.0")
		end



	end


end
