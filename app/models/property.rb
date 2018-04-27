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
		if rent_period_start.blank?
			nil
		else
			moved_in = rent_period_start
			rents.select{|rent| rent.date >= moved_in}
		end
	end

	def to_param
	  slug
	end

	def generate_slug
	  self.slug ||= self.full_address.parameterize if name_or_number && address1 && address2 && postcode
	  self.slug = self.full_address.parameterize if slug != self.full_address.parameterize
	end

	def self.current_void_rent
		sum{|house| house.balance if house.vacant?}
	end

	def self.total_lost_rent
		sum{|house| house.void_rent_total}
	end

	def balance
		if vacant?
			moved_out_and_accrue_void_rent
		else
			if rent_change_period?
				pre_post_rent
			else
				standard_rent
			end
		end
	end

	def vacant?
		moving_out_date == nil ? false : Time.now.to_date > moving_out_date
	end

	def rent_change_period? 
		(first_day_of_next_rent_period == nil) || (Time.now.to_date > first_day_of_next_rent_period) && ( moving_out_date.nil? || Time.now.to_date > moving_out_date) ? false : (Time.now.to_date >= first_day_of_next_rent_period)
	end

# calculators
	def rent_paid_on_to_day_before(from, to)
		rents.select{|rent| rent.date >= from  }.select{|rent| rent.date < to }.sum{|amount| amount.payment}
	end

	def rent_paid_on_to_including(from, to)
		rents.select{|rent| rent.date >= from }.select{|rent| rent.date <= to }.sum{|amount| amount.payment}
	end

	def rent_due_before(rent_amount, from, to)
		(rent_amount / 7) * ((to - from).to_i)
	end

	def rent_due_on_to_including(rent_amount, from, to)
		(rent_amount / 7) * ((to - from ).to_i + 1)
	end

	def standard_rent
		reset!
		now = Time.now.to_date
		paid = rent_paid_on_to_including(rent_period_start, now)
		due = rent_due_on_to_including(rent_per_week, rent_period_start, now)
		(paid - due) + rent_balance
	end

	def reset!
		self.update_columns(balance_created:nil) unless self.balance_created == nil
		lost_rent = void_rent_total
		lost_rent = end_of_tenancy_balance + void_rent_total if end_of_tenancy_balance?

		self.update_columns(void_rent_total:lost_rent)
		self.update_columns(balance_created:nil) unless balance_created.nil?
		self.update_columns(end_of_tenancy_balance: 0.0)
	end

	def pre_post_rent
		rent_before if balance_created.nil?
		balance_after_change + rent_balance
	end

	def rent_before
		paid = rent_paid_on_to_day_before(rent_period_start, first_day_of_next_rent_period)
		due = rent_due_before(rent_per_week, rent_period_start, first_day_of_next_rent_period)
		end_of_period = (paid - due) + rent_balance
		update_balance!(end_of_period)
		end_of_period
	end
	
	def update_balance!(end_of_period)
		self.update_columns(rent_balance:end_of_period) 
		self.update_columns(balance_created:Time.now)
	end

	def balance_after_change
		now = Time.now.to_date
		(rent_paid_on_to_including(first_day_of_next_rent_period, now)) - (rent_due_on_to_including(new_rent_value, first_day_of_next_rent_period, now))
	end

	def moved_out_and_accrue_void_rent
		make_final_balance unless end_of_tenancy_balance.nil?
		void_rent
	end

	def rent_rise_before_final_balance?
		first_day_of_next_rent_period == nil ? false : first_day_of_next_rent_period <= moving_out_date
	end

	def make_final_balance
		if rent_rise_before_final_balance?
			paid = rent_paid_on_to_day_before(rent_period_start, first_day_of_next_rent_period)
			due = rent_due_before(rent_per_week, rent_period_start, first_day_of_next_rent_period)
			pre = (paid - due)
			postpaid = rent_paid_on_to_including(first_day_of_next_rent_period, moving_out_date)
			postdue = rent_due_on_to_including(new_rent_value, first_day_of_next_rent_period, moving_out_date)
			post = (postpaid - postdue)
			final =( post + pre) + rent_balance
		else
			paid = rent_paid_on_to_including(rent_period_start, moving_out_date)
			due = rent_due_on_to_including(rent_per_week, rent_period_start, moving_out_date)
			final = (paid - due) + rent_balance
		end
		moving_out!(final)
	end

	def moving_out!(final)
		self.update_columns(end_of_tenancy_balance:final)
		self.update_columns(balance_created:nil) unless balance_created.nil?
		self.update_columns(rent_balance:0)
	end

	def void_rent
		now = Time.now.to_date
		from = moving_out_date + 1
		if rent_increase_whilst_vacant?
			rent_pre = (rent_due_before(rent_per_week, moving_out_date, first_day_of_next_rent_period)) 
			rent_post = (rent_due_on_to_including(new_rent_value, first_day_of_next_rent_period, now))
			-(rent_pre + rent_post)
		else			
			-(rent_due_on_to_including(rent_per_week, from, now))
		end
	end

	def rent_increase_whilst_vacant?
		first_day_of_next_rent_period.blank? || moving_out_date.blank? ? false : (moving_out_date < Time.now.to_date && first_day_of_next_rent_period <= Time.now.to_date)
	end

	private

	def no_dates
	  errors.add(:rent_period_start, "and moving out date cannot both be blank, (either can individually), if the house is empty set last day of rent period to the last day the property was let, or the day before you wish to start calculating the void rent.") if rent_period_start.blank? && moving_out_date.blank? 
	  errors.add(:moving_out_date, "and rent period start cannot both be blank, (either can individually), if the house is empty set last day of rent period to the last day the property was let, or the day before you wish to start calculating the void rent.") if rent_period_start.blank? && moving_out_date.blank?
	end

	def smarten_address
		self.name_or_number = self.name_or_number.titleize
		self.address1 = self.address1.titleize
		self.address2 = self.address2.titleize
		self.postcode.upcase!
	end
end
