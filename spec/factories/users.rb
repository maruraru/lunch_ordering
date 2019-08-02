require 'faker'

FactoryBot.define do
  factory :user do
    user_name { Faker::Name.name }
    email { Faker::Internet.email }
    current_password = Faker::Internet.password(6, 128)
    password { current_password }
    password_confirmation { current_password }
  end
end
