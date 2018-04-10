class Rent < ApplicationRecord
	
  belongs_to :property

	validates_numericality_of :payment, 								
							presence: true,
							greater_than_or_equal_to: 0

	validates :property_id, presence: true

	validates :date, presence: true

	validates :notes,	
							format: {with: /\A[a-z0-9\s\-\,\.\(\)\/\£]+\Z/i, message:"- you've used an invalid character"},
							allow_blank: true

	scope :last_first, ->{order(date: :desc).joins(:property).merge(Property.order(address1: :asc).order(name_or_number: :asc))}

	scope :first_payment_date, ->{last_first.last.date}
	scope :by_house, ->(number){order(date: :desc).includes(:property).merge(Property.where('property_id = ?',number))}


	def self.total
		self.sum{|rent| rent.payment}
	end

	def self.to_csv
		CSV.generate do |csv|
			csv << ["Payment ID", "Property", "Date", "Amount", "Notes"]
			all.each do |rent|
					row = [rent.id, rent.property.full_address, rent.date, rent.payment, rent.notes ]
					csv << row
			end
		end
	end
end
