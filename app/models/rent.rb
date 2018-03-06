class Rent < ApplicationRecord
  belongs_to :property

	validates :payment, 								
							presence: true,
							numericality: { greater_than: 0}

	validates :notes,	
							format: {with: /\A[A-Za-z0-9\-\/\.\'\,\s]+\z/, message:'letters or numbers only'},
							allow_blank: true

	scope :last_first, ->{order(date: :desc).order(property_id: :asc).order(notes: :asc)}


end
