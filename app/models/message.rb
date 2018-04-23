class Message
	include ActiveModel::Model
	attr_accessor :name, :email, :body

	validates :name, 	presence: true,
										format: { with: /\A[a-z\s]+\Z/i, message: "only letters" },
                   	length: { minimum: 1}

  validates :email, presence: true,
            				format: /\A\S+@\S+\z/

	validates :body,	presence: true,
										format: {with: /\A[A-Za-z0-9\/\.\'\&\£\+\-\,\s]+\z/, message:"- you've used an invalid character"}
end
