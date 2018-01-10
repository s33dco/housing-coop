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
                    									message: "Email address already in use"}

  validates :phone, 		numericality: true,
  											length: {minimum: 10, maximum: 14}

  before_validation :downcase_email
  after_validation :tidy_name

  scope :housed, ->{ where("housed = ?",true).order(firstname) }
  scope :members, ->{ where("member = ?",true).order(firstname) }
  scope :moved_out, ->{ where("housed = ?",false).order(firstname) }




  def tidy_name
    self.firstname = self.firstname.downcase.titleize
    self.lastname = self.lastname.downcase.titleize
  end

end