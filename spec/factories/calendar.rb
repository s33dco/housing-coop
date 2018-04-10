FactoryBot.define do
	factory :calendar do
		date_time{ 1.month.from_now}
		where '15 Mount Pleasant Street'
		title 'General Meeting'
		details 'another meeting'
	end
end