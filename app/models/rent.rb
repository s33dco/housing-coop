class Rent < ApplicationRecord
  belongs_to :property

	validates_numericality_of :payment, 								
							presence: true,
							greater_than_or_equal_to: 0

	validates :property_id, presence: true

	validates :notes,	
							format: {with: /\A[a-z0-9\s\-\,\.\(\)\/\£]+\Z/i, message:"- you've used an invalid character"},
							allow_blank: true

	scope :last_first, ->{order(date: :desc).joins(:property).merge(Property.order(address1: :asc).order(name_or_number: :asc))}

	scope :first_payment_date, ->{last_first.last.date}


	def self.total
		self.sum{|rent| rent.payment}
	end
end
