class Rent < ApplicationRecord
  belongs_to :property

	validates_numericality_of :payment, 								
							presence: true,
							greater_than_or_equal_to: 0

	validates :property_id presence: true

	validates :notes,	
							format: {with: /\A[A-Za-z0-9\-\/\.\'\£\+\-\,\s]+\z/, message:'letters or numbers only'},
							allow_blank: true

	scope :last_first, ->{order(date: :desc).order(property_id: :asc).order(notes: :asc)}
	scope :first_payment_date, ->{last_first.last.date}


	def self.total
		self.sum{|rent| rent.payment}
	end
end
