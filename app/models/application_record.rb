class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def downcase_email
    self.email.downcase!
  end

  def strip_spaces
  	if self.phone.nil?
  		self.phone.delete!(' ').gsub(/\D/)
  	end
  end


end
