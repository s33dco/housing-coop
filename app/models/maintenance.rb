class Maintenance < ApplicationRecord

	belongs_to :property
	belongs_to :contractor
	belongs_to :worktype, -> { order(title: :desc) }

	validates :cost, 								
							presence: true,
							numericality: {greater_than_or_equal_to: 0.00}

	validates :date, presence: true

	validates :worktype_id, presence: true

	validates :property_id, presence: true	

	validates :contractor_id, presence: true

	validates :details,
							presence: true,
							format: {with: /\A[A-Za-z0-9\/\.\'\&\£\+\-\,\s]+\z/, message:"- you've used an invalid character"}

	scope :first_job_first, ->{order(date: :desc).joins(:property).merge(Property.order(address1: :asc).order(name_or_number: :asc))}
	scope :first_job_date, ->{order(date: :desc).last.date}
	scope :worktype, ->(type){order(date: :desc).joins(:worktype).merge(Worktype.where('worktype_id = ?',type))}


	def self.total
		self.sum{|maintenance| maintenance.cost}
	end

	def self.to_csv
		CSV.generate do |csv|
			csv << ["Maintenance ID", "Property", "Date", "Cost", "Category", "Contractor", "Details"]
			all.each do |result|
					row = [result.id, result.property.full_address, result.date, result.cost, result.worktype.title, result.contractor.name, result.details ]
					csv << row
			end
		end
	end

end
