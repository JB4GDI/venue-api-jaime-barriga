require 'rails_helper'

RSpec.describe Venue, type: :model do
  
  # Association test
  # A venue should belong to one Venueadmin
  it { should belong_to(:venueadmin) }
  # A venue should have many categories (like Profile/Home Rental/Planning)
  it { should have_many(:categorys) }

  # Validation tests
  # Make sure we have BOTH of these present before saving
  it { should validate_presence_of(:name) }
end
