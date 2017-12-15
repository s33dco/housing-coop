class Rent < ApplicationRecord
  belongs_to :property

	validates :payment, 								
							presence: true,
							numericality: {greater_than_or_equal_to: 0.00}

	validates :notes,	
							format: {with: /\A[A-Za-z0-9\-\/\.\'\,\s]+\z/, message:'letters or numbers only'}


end
