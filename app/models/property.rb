class Property < ApplicationRecord

	has_many :people

	validates :house_name_no,	:address1, :address2,	
												presence: true,
												format: /\A[A-Za-z0-9\-\/\.\,\s]+\z/

	validates :postcode,	length: {minimum: 6, maximum: 9},
												format: /(([gG][iI][rR] {0,}0[aA]{2})|((([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y]?[0-9][0-9]?)|(([a-pr-uwyzA-PR-UWYZ][0-9][a-hjkstuwA-HJKSTUW])|([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y][0-9][abehmnprv-yABEHMNPRV-Y]))) {0,}[0-9][abd-hjlnp-uw-zABD-HJLNP-UW-Z]{2}))/
                    					
	validates :rent_per_week, 	presence: true,
															numericality: {greater_than_or_equal_to: 0.00}

end
