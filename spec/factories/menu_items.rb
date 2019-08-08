require 'faker'

FactoryBot.define do
  factory :menu_item do
    name { Faker::Food.dish }
    category { MenuItem::CATEGORIES[Random.rand(3)] }
    price { Faker::Number.decimal }
    photo { "" }
    association :menu
  end
end
