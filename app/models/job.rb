class Job < ApplicationRecord
	has_many :roles
	has_many :people, through: :roles


	validates :title, presence: true,
									format: { with: /\A[a-zA-Z0-9 \-\/\.\'\,]+\Z/, message: "only allows letters" }

	validates :email, 		presence: true,
	                  		format: /\A\S+@\S+\z/,
	                  		uniqueness: { case_sensitive: false , 
	                  									message: "Email address already in use"},
	                      allow_blank: true


	before_validation :clean_title

	scope :alphabetically, ->{ order(title: :asc)}


private

	def clean_title
		self.title = self.title.titleize
	end

end
