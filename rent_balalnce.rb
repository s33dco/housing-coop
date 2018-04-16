
def balance
	accrue_void_rent if vacant?
	standard_rent if standard_process?
	pre_post_rent if rent_change_period?
	return balance
end

# when the property is empty

def accrue_void_rent
	moving_out!
	void_rent
end


def moving_out!
	self.update_columns(balance_created:nil) unless self.balance_created == nil
	self.update_columns(end_of_tenancy:rent_balance) unless self.rent_balance == nil
	self.update_columns(rent_balance:nil)
end


def void_rent
	balance = (rent_per_week / 7) * ((Time.now.to_date - last_day_of_rent_period ).to_i)
end



# dealing with rent change period

def pre_post_rent
	rent_before unless balance_created.present?
	balance = rent_after(first_day_of_next_rent_period)
end


def rent_before
	paid = (self.rents.select{|rent| rent.date < first_day_of_next_rent_period}.sum{|rent|rent.payment}) 
	due =  (self.rent_per_week / 7) * ((first_day_of_next_rent_period - rent_period_start).to_i) + rent_balance
	end_of_period = paid - due
	update_balance!(end_of_period)
end

def update_balance!
	self.update_columns(rent_balance:end_of_period) 
	self.update_columns(balance_created:Time.now)
end

def rent_after
	paid = rents.select{|rent| rent.date >= first_day_of_next_rent_period}.sum{|amount| amount.payment}
	due = ((new_rent_value / 7) * ((Time.now.to_date - first_day_of_next_rent_period ).to_i + 1)) + rent_balance
	balance = paid - due
end



# standard process - not over a rent change

def standard_rent
	reset!
	paid = rents.select{|rent| rent.date >= rent_period_start}.sum{|amount| amount.payment}
	due = ((rent_per_week / 7) * ((Time.now.to_date - rent_period_start ).to_i + 1)) + rent_balance
	balance = paid - due
end

def reset!
	self.update_columns(balance_created:nil) unless self.balance_created == nil
	self.update_columns(end_of_tenancy:nil) unless self.balance_created == nil
end

# logics

def vacant?
	people.nil? || rent_period_start.nil? && Time.now.to_date >= last_day_of_rent_period
end

def rent_change_period?
	first_day_of_next_rent_period !=nil && Time.now.to_date >= first_day_of_next_rent_period
end

def standard_process?
	first_day_of_next_rent_period.blank? || Time.now.to_date < first_day_of_next_rent_period
end
	
