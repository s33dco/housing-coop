class Maintenance < ApplicationRecord

	belongs_to :property
	belongs_to :contractor
	belongs_to :worktype, -> { order(title: :desc) }

	validates :cost, 								
							presence: true,
							numericality: {greater_than_or_equal_to: 0.00}


	validates :worktype_id, presence: true

	validates :property_id, presence: true	

	validates :contractor_id, presence: true

	validates :details,
							presence: true,
							format: {with: /\A[A-Za-z0-9\-\/\.\'\,\s]+\z/, message:'letters or numbers only'}

	scope :first_job_first, ->{order(date: :desc)}
	scope :first_job_date, ->{order(date: :desc).last.date}

	def self.total
		self.sum{|maintenance| maintenance.cost}
	end

end
