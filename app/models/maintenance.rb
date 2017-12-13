class Maintenance < ApplicationRecord

	belongs_to :property
	belongs_to :contractor

	validates :cost, 								
							presence: true,
							numericality: {greater_than_or_equal_to: 0.00}


	validates :details,	:worktype,	
							presence: true,
							format: {with: /\A[A-Za-z0-9\-\/\.\'\,\s]+\z/, message:'letters or numbers only'}


end
