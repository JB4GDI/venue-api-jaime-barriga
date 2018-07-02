# spec/factories/venueadmins.rb
FactoryBot.define do
  factory :venueadmin do
    name { Faker::Lorem.word }
    email { Faker::Lorem.word }
  end
end