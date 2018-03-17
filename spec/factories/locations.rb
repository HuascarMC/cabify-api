FactoryBot.define do
  factory :location do
    lon { Faker::Address.longitude }
    lat { Faker::Address.latitude }
    cab_id nil    
  end
end
