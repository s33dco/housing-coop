FactoryBot.define do
	factory :person do
		firstname 'percy'
		lastname 'parker'
		email "percyparker@example.com"
		phone "07777777777"
		joined {5.years.ago}
		member true
		housed true
		admin true
		secretary true
		rent_officer true
		maintenance true
		password "password"
 		password_confirmation "password"
 		association :property, strategy: :build_stubbed
	end
end