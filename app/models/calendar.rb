class Calendar < ApplicationRecord

	has_many :participations
	has_many :people, through: :participations

	validates :when, 	presence: true
	validates :title, :details, :where, 
										presence: true,
										format: {with: /\A[A-Za-z0-9\-\/\.\'\,\s]+\z/, message:'letters or numbers only'}

				

end
