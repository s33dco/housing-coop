def balance
	if self.rents.empty?
			return nil
	else
		start_date = self.rents.last.date
		if Time.now.to_date < self.rent_change
		 	total_rent = self.rents.sum{|amount| amount.payment}
			number_of_days = (Time.now.to_date - start_date.to_date).to_i
			(total_rent - ((self.rent_per_week / 7) * number_of_days)) + self.rent_balance
		else
			# work out rent balance before change date
			pre_change_payments = self.rents.select{|rent| rent.date < rent.property.rent_change}.sum{|rent|rent.payment}
			pre_change_days = (self.rent_end - self.rent_begin).to_i
			pre_change_balance = (((self.rent_per_week / 7) * number_of_days) - pre_change_payments) + self.rent_balance
			self.rent_balance = pre_change_balance
			self.rent_balance.save
			# then work out rent on and after change
			post_change_payments = house.rents.select{|payment| payment.date < self.rent_change }.sum{|rent|rent.payment}
			post_days = (Time.now.to_date - self.rent_change).to_i
			(((self.new_rent_value / 7) * post_days) - post_change_payments) + self.rent_balance
		end
	end
end
