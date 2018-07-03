class Category < ApplicationRecord
  
  # Associations
  belongs_to :venue
  has_many :photos

  # Validations
  validates_presence_of :name
end
