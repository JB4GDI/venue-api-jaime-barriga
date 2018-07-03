require 'rails_helper'

RSpec.describe Photo, type: :model do

  # Association test
  # A Photo should belong to one Category
  it { should belong_to(:category) }

  # Validation tests
  # Make sure we have ALL of these present before saving
  it { should validate_presence_of(:filename) }
  # it { should validate_presence_of(:caption) }
  it { should validate_presence_of(:rank) }
end
