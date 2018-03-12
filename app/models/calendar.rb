class Calendar < ApplicationRecord

	has_many :participations
	has_many :people, through: :participations

	validates :when, 	presence: true
	validates :title, :details, :where, 
										presence: true,
										format: {with: /\A[A-Za-z0-9\-\/\.\'\&\£\+\-\,\s]+\z/, message:'letters or numbers only'}
	validates :details, 
	            format: {with: /\A[A-Za-z0-9\-\/\.\'\&\£\+\-\,\s]+\z/, message:'letters or numbers only'},
	            allow_blank: true

	before_validation :clean_title

private

	def clean_title
		self.title = self.title.downcase.titleize
	end

				

end
