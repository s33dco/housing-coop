FactoryBot.define do
	factory :role do
		role_start {1.year.ago}
		role_end {1.month.from_now}
		person
		job
	end
end