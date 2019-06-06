class Calendar < ApplicationRecord


	has_many :participations
	has_many :people, through: :participations

	validates :date_time, 	presence: true

	validates :title, :details, :where,
										presence: true,
										format: {with: /\A[a-z0-9\s\-\,\.\(\)\/\&\£\!\?\']+\Z/i, message:"- you've used an invalid character"}
	# validate :link

	before_validation :clean_title

	scope :upcoming, ->{where("date_time >= ?" , Time.now).order(date_time: :asc)}
	scope :past, -> {where("date_time < ?" , Time.now).order(date_time: :desc)}
	scope :future_to_past, ->{order(date_time: :desc)}

	def past?
		Time.now.to_date > date_time
	end

private

	def clean_title
		self.title = self.title.downcase.titleize
	end
end
