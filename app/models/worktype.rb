class Worktype < ApplicationRecord
  has_many :maintenances

  	validates :title, 		uniqueness: true,
  												presence: true,
  											  format: { with: /\A[a-z0-9\s\-\.]+\Z/i, message: "only letters" }



  	scope :alphabetically, ->{ order(title: :asc)}


end

