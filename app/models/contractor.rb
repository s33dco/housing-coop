class Contractor < ApplicationRecord
	has_many :maintenances
	has_many :properties, through: :maintenances

		validates :name,	:details,	
								presence: true,
								format: {with: /\A[a-zA-Z0-9 \-\/\.\'\,]+\Z/, message:'letters or numbers only'}

		validates :phone, 					
								presence: true, numericality: true,
  							length: {minimum: 10, maximum: 14}

  	validates :email, 					
  							presence: true,
                format: {with: /\A\S+@\S+\z/, message: 'please check the email address'}

    before_validation :downcase_email, :clean_name


private

  def clean_name
    self.name = self.name.downcase.titleize
  end

end
