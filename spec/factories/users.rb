FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    self_introduction { Faker::Lorem.characters(number: 150) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end