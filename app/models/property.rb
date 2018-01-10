class Property < ApplicationRecord

	has_many :people
	has_many :rents
	has_many :maintenances
	has_many :contractors, through: :maintenances

	validates :house_name_no,	:address1, :address2, :postcode,	
						presence: true,
						format: {with: /\A[A-Za-z0-9\-\/\.\,\s]+\z/, message:'letters or numbers only'}

	validates :postcode,	
						length: {minimum: 6, maximum: 9},
						format: /(([gG][iI][rR] {0,}0[aA]{2})|((([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y]?[0-9][0-9]?)|(([a-pr-uwyzA-PR-UWYZ][0-9][a-hjkstuwA-HJKSTUW])|([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y][0-9][abehmnprv-yABEHMNPRV-Y]))) {0,}[0-9][abd-hjlnp-uw-zABD-HJLNP-UW-Z]{2}))/
                    					
	validates :rent_per_week, 	
						presence: true,
						numericality: {greater_than_or_equal_to: 0.00}

	before_validation :smarten_address


private

	def smarten_address
		self.house_name_no = self.house_name_no.titleize
		self.address1 = self.address1.titleize
		self.address2 = self.address2.titleize
		self.postcode.upcase!
	end

end
