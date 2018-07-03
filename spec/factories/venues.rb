# spec/factories/venues.rb
FactoryBot.define do
  factory :venue do
    name { Faker::Lorem.word }
    venueadmin_id nil
  end
end