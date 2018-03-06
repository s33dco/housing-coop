class Person < ApplicationRecord

  belongs_to :property
  has_many :roles
  has_many :jobs, through: :roles
  has_many :participations
  has_many :events, through: :participations, source: :calendar

	validates :firstname, presence: true,
											  format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/, message: "only allows letters" }

	validates :lastname, 	presence: true,
											  format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/, message: "only allows letters" },
												length: { minimum: 2 }

  validates :email, 		presence: true,
                    		format: /\A\S+@\S+\z/,
                    		uniqueness: { case_sensitive: false , 
                    									message: "Email address already in use"},
                        allow_blank: true

  validates :phone,     numericality: true,
  											length: {minimum: 10, maximum: 14},
                        allow_blank: true

  before_validation :downcase_email
  before_validation :strip_spaces
  after_validation :tidy_name
  # after_validation :tidy_words

  scope :housed, ->{ where("housed = ?",true).order('firstname asc') }
  scope :members, ->{ where("member = ?",true).order('firstname asc') }
  scope :non_members, ->{ where("member = ?",false).where("child = ?",false).order('firstname asc') }
  scope :moved_out, ->{ where("housed = ?",false).order('firstname asc') }
  scope :under18s, ->{ where("housed = ?",true).where("child = ?",true).order('firstname asc') }
  scope :members_adults_children, ->{ where("housed = ?", true).order("member desc").order("child asc").order("firstname desc") }

private
  # def tidy_words
  #   self.words = self.words.humanize
  # end

  def downcase_email
    self.email.downcase!
  end

  def strip_spaces
    if self.phone.nil?
      self.phone.delete!(' ').gsub(/\D/)
    end
  end

  def tidy_name
    self.firstname = self.firstname.downcase.titleize
    self.lastname = self.lastname.downcase.titleize
  end

end