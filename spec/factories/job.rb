FactoryBot.define do
	factory :job do
		sequence(:title){|n| "Secretary#{n}"}
		sequence(:email){|n| "#{title}@example.com"}
	end
end