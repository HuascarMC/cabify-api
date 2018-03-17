FactoryBot.define do
  factory :cab do
    state { ['free', 'hired'].sample }
    name { Faker::Name.name }
    city { Faker::Address.city }
  end
end
