# spec/factories/photos.rb
FactoryBot.define do
  factory :photo do
    filename { Faker::Lorem.word }
    caption { Faker::Lorem.word }
    rank { Faker::Number.number(3) }
    category_id nil
  end
end