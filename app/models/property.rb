class Property < ApplicationRecord

	has_many :people
	has_many :rents, -> { order(date: :desc).order(notes: :asc) }
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

	validates :new_rent_value,
						allow_blank: true,
						numericality: {greater_than_or_equal_to: 0.00}

	before_validation :smarten_address

	scope :by_street_name_number, ->{where("coop_house = ?", true).order(address1: :asc).order(house_name_no: :asc)}
	scope :former_coop, ->{where("coop_house = ?", false)}
	scope :rent_report, ->{by_street_name_number.where("rent_begin = ?", !nil)}

	def balance
		if self.rents.blank? || self.rent_begin.nil?
				return nil
		else
			# if before the date rent is due to change
			if self.rent_change.nil? || Time.now.to_date < self.rent_change
				# reset balances_created to nil
				self.update_columns(balance_created:nil)
				# calculate rent position (rent_paid - rent_due) + self.rent_balance
				(self.rents.select{|rent| rent.date >= self.rent_begin}.sum{|amount| amount.payment} - ((self.rent_per_week / 7) * (Time.now.to_date - self.rent_begin ).to_i)) + self.rent_balance
			else
				unless self.balance_created.present?
					# work out rent position pre change and update rent_balance
					# pre_change_balance = (pre_change_rent_paid - pre_change_rent_due )
					pre_change_balance = (self.rents.select{|rent| rent.date < rent.property.rent_change}.sum{|rent|rent.payment}) - ((self.rent_per_week / 7) * ((self.rent_end - self.rent_begin).to_i + 1))
					end_of_rent_period_balance = pre_change_balance + self.rent_balance
					# update rent_balance with value, timestamp change
					self.update_columns(rent_balance:end_of_rent_period_balance) 
					self.update_columns(balance_created:Time.now)
				end
				# calculate rent position (rent_paid - rent_due) +  updated rent_balance for new period
				# (post_rent_change_paid - post_rent_change_due) + self.rent_balance
				((self.rents.select{|payment| payment.date >= self.rent_change }.sum{|rent|rent.payment}) - ((self.new_rent_value / 7) * (Time.now.to_date - self.rent_change).to_i)) + self.rent_balance
			end
		end
	end


private

	def smarten_address
		self.house_name_no = self.house_name_no.titleize
		self.address1 = self.address1.titleize
		self.address2 = self.address2.titleize
		self.postcode.upcase!
	end
end
