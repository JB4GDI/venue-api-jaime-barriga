class Venueadmin < ApplicationRecord

  # Associations
  has_many :venues

  # Validations
  validates_presence_of :name, :email
end
