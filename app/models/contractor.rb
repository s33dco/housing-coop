class Contractor < ApplicationRecord
	has_many :maintenances

		validates :name,	:details,	
								presence: true,
								format: {with: /\A[A-Za-z0-9\-\/\.\'\,\s]+\z/, message:'letters or numbers only'}

		validates :phone, 					
								presence: true, numericality: true,
  							length: {minimum: 10, maximum: 14}

  	validates :email, 					
  							presence: true,
                format: {with: /\A\S+@\S+\z/, message: 'please check the email address'}
end
