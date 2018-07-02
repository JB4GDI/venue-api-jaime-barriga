class Venueadmin < ApplicationRecord

  # Validations
  validates_presence_of :name, :email
end
