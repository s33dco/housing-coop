class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def downcase_email
    self.email.downcase!
  end

end
