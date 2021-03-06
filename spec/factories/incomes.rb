FactoryBot.define do
  factory :income do
    income_category_id   { Faker::Number.between(from: 2, to: 10) }    # id=1は"--"
    remarks              { Faker::Lorem.sentence }
    price                { Faker::Number.between(from: 1, to: 10_000_000) }
    income_date          { Faker::Date.between(from: Date.today.years_ago(10), to: Date.today.years_since(5)) }
    association :user
  end
end
