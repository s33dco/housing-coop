FactoryBot.define do
	factory :property do
		sequence(:name_or_number){|n| "#{n + 12}"}
		address1 "street road"
		address2 "city town"
		postcode "w1a 1aa"
		rent_per_week 70
		kitchen_upgrade {1.year.from_now}
		coop_house true
		new_rent_value 140
		first_day_of_next_rent_period {4.weeks.from_now}
		rent_period_start {4.weeks.ago}
		last_day_of_rent_period {27.days.from_now} 
	end
end