require 'rails_helper'

RSpec.describe Venueadmin, type: :model do

  # Association test
  # This model has a 1:many relationship with Venue
  it { should have_many(:venues) }

  # Validation tests
  # Make sure we have BOTH of these present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
end
