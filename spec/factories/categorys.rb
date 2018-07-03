# spec/factories/categorys.rb
FactoryBot.define do
  factory :category do
    name { Faker::Lorem.word }
    venue_id nil
  end
end