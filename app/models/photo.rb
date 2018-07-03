class Photo < ApplicationRecord

  # Associations
  belongs_to :category

  # Validations
  validates_presence_of :filename
  # validates_presence_of :caption
  validates_presence_of :rank
end
