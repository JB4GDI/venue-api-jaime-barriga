require 'rails_helper'

RSpec.describe Category, type: :model do
  
  # Association test
  # A Category should belong to one Venue
  it { should belong_to(:venue) }
  # A Category should have many photos
  it { should have_many(:photos) }

  # Validation tests
  # Make sure we have this present before saving
  it { should validate_presence_of(:name) }
end
