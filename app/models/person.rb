class Person < ApplicationRecord

  belongs_to :property
  has_many :roles
  has_many :jobs, through: :roles
  has_many :participations
  has_many :events, through: :participations, source: :calendar

	validates :firstname, presence: true,
											  format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }

	validates :lastname, 	presence: true,
											  format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" },
												length: { minimum: 2 }

  validates :email, 		presence: true,
                    		format: /\A\S+@\S+\z/,
                    		uniqueness: { case_sensitive: false , 
                    									message: "Email address already used"}

  validates :phone, 		numericality: true,
  											length: {minimum: 10, maximum: 14}

end