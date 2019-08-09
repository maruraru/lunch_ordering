FactoryBot.define do
  factory :user_lunch do
    association :user
    association :menu_item
  end
end
