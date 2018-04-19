
FactoryBot.define do
  factory :post do
    title { Faker::Lorem.word }
    url { Faker::Internet.url }
  end
end
