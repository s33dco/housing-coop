FactoryBot.define do
	factory :rent do
		property
		payment 70
		sequence(:date) {|n| n.month.ago}
	end
end