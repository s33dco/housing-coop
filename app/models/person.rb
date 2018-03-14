class Person < ApplicationRecord

  belongs_to :property

  has_many :roles, ->{ order(role_end: :desc).joins(:job).merge(Job.order(title: :asc))}
  has_many :jobs, through: :roles
  has_many :participations
  has_many :events, through: :participations, source: :calendar

	validates :firstname, presence: true,
											  format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/, message: "only letters" }

	validates :lastname, 	presence: true,
											  format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/, message: "only letters" },
												length: { minimum: 2 }

  validates :email, 		presence: true,
                    		format: /\A\S+@\S+\z/,
                    		uniqueness: { case_sensitive: false , 
                    									message: "Email address already in use"},
                        allow_blank: true

  validates :phone,     numericality:  {message: "- just digits no spaces"},
  											length: {minimum: 10, maximum: 14},
                        allow_blank: true

  before_validation :downcase_email
  after_validation :tidy_name
  after_validation :tidy_words

  scope :first_name_last, ->{ order('lastname asc').order('firstname asc') }
  scope :housed, ->{ where("housed = ?",true).first_name_last }
  scope :members, ->{ where("member = ?",true).first_name_last }
  scope :non_members, ->{ where("member = ?",false).where("child = ?",false).first_name_last }
  scope :moved_out, ->{ where("housed = ?",false).order('firstname asc') }
  scope :under18s, ->{ where("housed = ?",true).where("child = ?",true).first_name_last }
  scope :members_adults_children, ->{ where("housed = ?", true).order("member desc").order("child asc").first_name_last }

def events_since_joined(events)

  events.select{|event| event.date_time > self.joined}.size
end

def event_percent
  eventsattended = self.joined
  (self.events.size.to_f/Calendar.all.select{|event| event.date_time > eventsattended}.size)*(100)  
end  

private
  def tidy_words
    self.words = self.words.humanize
  end

  def tidy_name
    self.firstname = self.firstname.downcase.titleize
    self.lastname = self.lastname.downcase.titleize
  end

end