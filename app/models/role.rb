class Role < ApplicationRecord
  belongs_to :person
  belongs_to :job

validates :role_start, :role_end, presence: true
validate :role_end_not_before_start


private

	def role_end_not_before_start
	  if :role_end.present? && :role_end > :role_start
		      errors.add(:role_end, "must be later then start date")
		end
	end

end
 