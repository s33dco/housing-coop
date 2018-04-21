FactoryBot.define do
	factory :property do
		name_or_number "12"
		address1 "street road"
		address2 "city town"
		postcode "w1a 1aa"
		rent_per_week 70
		kitchen_upgrade {1.year.from_now}
		coop_house true
		new_rent_value {4.weeks.from_now}
		first_day_of_next_rent_period nil
		rent_period_start {4.weeks.ago}
		moving_out_date nil
		rent_balance 0
		end_of_tenancy_balance 0
		balance_created nil
		void_rent_total 0
	end
end