class Participation < ApplicationRecord
  belongs_to :person
  belongs_to :calendar
end
