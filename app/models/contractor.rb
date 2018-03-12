class Contractor < ApplicationRecord
	has_many :maintenances
	has_many :properties, through: :maintenances

		validates :name,	:details,	
								presence: true,
								format: {with: /\A[a-zA-Z0-9 \-\/\.\'\,]+\Z/, message:'letters or numbers only'}

		validates :phone, 					
								presence: true, numericality: true,
  							length: {minimum: 10, maximum: 14},
                allow_blank: true


  	validates :email, 					
  							presence: true,
                format: {with: /\A\S+@\S+\z/, message: 'please check the email address'},
                allow_blank: true

    validates :details, 
                format: {with: /\A[A-Za-z0-9\-\/\.\'\&\£\+\-\,\s]+\z/, message:'letters or numbers only'},
                allow_blank: true
                

    before_validation :downcase_email, :clean_name

    scope :alphabetically, ->{ order(name: :asc)}


private

  def clean_name
    self.name = self.name.downcase.titleize
  end

end
