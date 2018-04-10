FactoryBot.define do
	factory :maintenance do
		cost 70
		details 'Re-hung the backdoor'
		date {1.month.ago}
		contractor
		property
		worktype
	end
end