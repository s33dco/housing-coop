FactoryBot.define do
	factory :rent do
		property
		payment 70
		date {2.weeks.ago}
	end
end