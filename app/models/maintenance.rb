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
							format: {with: /\A[A-Za-z0-9\/\.\'\&\£\+\-\,\s]+\z/, message:"- you've used an invalid character"}

	scope :first_job_first, ->{order(date: :desc).joins(:property).merge(Property.order(address1: :asc).order(house_name_no: :asc))}
	scope :first_job_date, ->{order(date: :desc).last.date}

	has_many :roles, ->{ order(role_end: :desc).joins(:job).merge(Job.order(title: :asc))}

	def self.total
		self.sum{|maintenance| maintenance.cost}
	end

end
