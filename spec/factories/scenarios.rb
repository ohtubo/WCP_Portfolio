FactoryBot.define do
  factory :scenario do
  title { Faker::Lorem.characters(number: 10) }
  overview{ Faker::Lorem.characters(number: 250) }
  system_category{ Faker::Lorem.characters(number: 12) }
  level{ "★★★★★" }
  upper_limit_count{"上限なし"}
  lower_limit_count{"1人"}
  play_genre{"オンライン"}
  play_time{"8時間"}
  content{ Faker::Lorem.characters(number: 5000) }
  end
end