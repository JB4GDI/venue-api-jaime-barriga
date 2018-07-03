class Venue < ApplicationRecord

  # Associations
  belongs_to :venueadmin
  has_many :categorys

  # Validations
  validates_presence_of :name
end
