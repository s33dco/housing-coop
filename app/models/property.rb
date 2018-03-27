class Property < ApplicationRecord

	has_many :people
	has_many :rents, -> { order(date: :desc).order(notes: :asc) }
	has_many :maintenances, -> { order(date: :desc)}
	has_many :contractors, through: :maintenances

	validates :slug, uniqueness: {message: "The same address is already in use"}


	validates :name_or_number,:address1, :address2,	
						presence: true,
						format: {with: /\A[a-z0-9\s\-\,\.\(\)\/]+\Z/i , message:"- you've used an invalid character"}

	validates :postcode,	
						presence: true,
						length: {minimum: 6, maximum: 9},
						format: /(([gG][iI][rR] {0,}0[aA]{2})|((([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y]?[0-9][0-9]?)|(([a-pr-uwyzA-PR-UWYZ][0-9][a-hjkstuwA-HJKSTUW])|([a-pr-uwyzA-PR-UWYZ][a-hk-yA-HK-Y][0-9][abehmnprv-yABEHMNPRV-Y]))) {0,}[0-9][abd-hjlnp-uw-zABD-HJLNP-UW-Z]{2}))/
                    					
	validates :rent_per_week,
						presence: true,
						numericality: {greater_than_or_equal_to: 0.00}

	validates :new_rent_value,
						allow_blank: true,
						numericality: {greater_than_or_equal_to: 0.00}

	validate :no_dates

	
	before_validation :generate_slug
	before_save :smarten_address

	scope :by_street_name_number, ->{where("coop_house = ?", true).order(address1: :asc).order(name_or_number: :asc)}
	scope :former_coop, ->{where("coop_house = ?", false)}



	def rent_paid_by_tenant
		if self.rent_period_start.blank?
			return nil
		else
		moved_in = self.rent_period_start
		 return self.rents.select{|rent| rent.date >= moved_in}
		end
	end


	def balance
		# if the property is empty 
		if self.people.nil? || self.rent_period_start.nil? && Time.now.to_date >= self.last_day_of_rent_period
			# reset rent_balance as this should have been collected before end of tenancy any money owed is stored in end_of_tenancy
			self.update_columns(balance_created:nil) unless self.balance_created == nil
				if self.first_day_of_next_rent_period.nil? || Time.now.to_date < self.first_day_of_next_rent_period
					# calc lost rent at standard rate per day
					balance = -(self.rent_per_week / 7) * ((Time.now.to_date - self.last_day_of_rent_period).to_i)
				else
					# calc new rent due and add it to old rent
					balance = -((((Time.now.to_date - self.first_day_of_next_rent_period).to_i + 1) * self.new_rent_value/7) + ((self.rent_per_week / 7) * ((Time.now.to_date - self.last_day_of_rent_period).to_i - 1 )))
				end
		else
		# else if property occupied and before the any rent change
			if self.first_day_of_next_rent_period.blank? || Time.now.to_date < self.first_day_of_next_rent_period
				# reset balances_created to nil if not already
				self.update_columns(balance_created:nil) unless self.balance_created == nil
				# calculate rent position (rent_paid - rent_due) + self.rent_balance
				balance = self.rents.select{|rent| rent.date >= self.rent_period_start}.sum{|amount| amount.payment} - (self.rent_per_week / 7) * ((Time.now.to_date - self.rent_period_start ).to_i + 1) + self.rent_balance
			else
		# over a rent change period
				unless self.balance_created.present?
					# work out rent position pre change and update rent_balance
					# pre_change_balance = (pre_change_rent_paid - pre_change_rent_due )
					pre_change_balance = (self.rents.select{|rent| rent.date <= rent.property.rent_change}.sum{|rent|rent.payment}) - ((self.rent_per_week / 7) * ((self.last_day_of_rent_period - self.rent_period_start).to_i + 1))
					end_of_rent_period_balance = pre_change_balance + self.rent_balance
					# update rent_balance with value, timestamp change
					self.update_columns(rent_balance:end_of_rent_period_balance) 
					self.update_columns(balance_created:Time.now)
				end
			# calculate rent position (rent_paid - rent_due) +  updated rent_balance for new period
			post_rent_change_paid = self.rents.select{|payment| payment.date >= self.first_day_of_next_rent_period }.sum{|rent|rent.payment}
			post_rent_change_due = (self.new_rent_value / 7) * ((Time.now.to_date - self.first_day_of_next_rent_period).to_i + 1)
			paid_less_due = post_rent_change_paid - post_rent_change_due
			balance = paid_less_due + self.rent_balance
		end
		# catch the last day of tenancy balance
		if Time.now.to_date == self.last_day_of_rent_period
			self.update_columns(end_of_tenancy:self.rent_balance) unless self.balance_created == nil
		else
			# reset end of tenancy balance if new tenant
			if Time.now.to_date > self.rent_period_start
				self.update_columns(end_of_tenancy:nil) unless self.balance_created == nil
			end
		end
	end	
	return balance
end

def to_param
  slug
end

def generate_slug
  self.slug ||= self.full_address.parameterize if name_or_number && address1 && address2 && postcode
  self.slug = self.full_address.parameterize if slug != self.full_address.parameterize
end

private

	def no_dates
	  errors.add(:rent_period_start, "and last day of rent period cannot both be blank, (either can individually), if the house is empty set last day of rent period to the last day the property was let, or the day before you wish to start calculating the void rent.") if rent_period_start.blank? && last_day_of_rent_period.blank? 
	  errors.add(:last_day_of_rent_period, "and rent period start cannot both be blank, (either can individually), if the house is empty set last day of rent period to the last day the property was let, or the day before you wish to start calculating the void rent.") if rent_period_start.blank? && last_day_of_rent_period.blank?
	end

	def smarten_address
		self.name_or_number = self.name_or_number.titleize
		self.address1 = self.address1.titleize
		self.address2 = self.address2.titleize
		self.postcode.upcase!
	end
end
