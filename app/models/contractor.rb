class Contractor < ApplicationRecord

	has_many :maintenances
	has_many :properties, through: :maintenances

    validates :slug, uniqueness: {message: "The same contractor name is already in use"}

		validates :name,
								presence: true,
								format: { with: /\A[a-z0-9\s\-\']+\Z/i, message: "- you've used an invalid character" }

		validates :phone,
								presence: true, numericality: true,
  							length: {minimum: 10, maximum: 14},
                allow_blank: true


  	validates :email,
                format: {with: /\A\S+@\S+\z/, message: 'please check the email address'},
                allow_blank: true

    validates :details,
                format: { with: /\A[a-z0-9\s\-\,\.\(\)\/\£\']+\Z/i, message: "- you've used an invalid character" },
                allow_blank: true

    before_validation :generate_slug
    before_validation :downcase_email, :clean_name

    scope :alphabetically, ->{ order(name: :asc)}

    def to_param
      slug
    end

    def generate_slug
      self.slug ||= self.name.parameterize if name
      self.slug = self.name.parameterize if slug != self.name.parameterize
    end

private

  def clean_name
    self.name = self.name.downcase.titleize
  end

end
