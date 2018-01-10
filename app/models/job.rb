class Job < ApplicationRecord
	has_many :roles
	has_many :people, through: :roles


	validates :title, presence: true,
									format: { with: /\A[a-zA-Z0-9 \-\/\.\'\,]+\Z/, message: "only allows letters" }

	before_validation :clean_title

	def clean_title
		self.title = self.title.titleize
	end

end
