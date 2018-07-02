require 'rails_helper'

RSpec.describe Venueadmin, type: :model do

  # Validation tests
  # Make sure we have BOTH of these present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
end
