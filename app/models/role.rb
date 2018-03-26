class Role < ApplicationRecord
  belongs_to :person
  belongs_to :job

validates :role_start, :role_end, presence: true
validate :role_end_not_before_start

scope :current, ->{ where("role_end >  ?", Time.now.to_date).joins(:job).merge(Job.order(title: :asc))}
scope :by_title_going_back, ->{ order(role_end: :desc).joins(:job).merge(Job.order(title: :asc))}
scope :role_type, ->(type){order(role_end: :desc).joins(:job).merge(Job.where('job_id = ?',type))}

private

	def role_end_not_before_start
	  if :role_end.present? && :role_end > :role_start
		      errors.add(:role_end, "must be later then start date")
		end
	end

end
 