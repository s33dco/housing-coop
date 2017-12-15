class Role < ApplicationRecord
  belongs_to :person
  belongs_to :job
end
