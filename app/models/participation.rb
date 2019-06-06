class Participation < ApplicationRecord
  belongs_to :person
  belongs_to :calendar

  validates :person, presence: true
  validates :calendar, presence: true

end
