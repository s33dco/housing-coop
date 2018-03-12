class Worktype < ApplicationRecord
  has_many :maintenances

  	validates :title, 		uniqueness: true,
  												presence: true,
  											  format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/, message: "only letters" }



  	scope :alphabetically, ->{ order(title: :asc)}


end

