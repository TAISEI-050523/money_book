FactoryBot.define do
  factory :income do
    income_category_id { Faker::Number.between(from: 2, to: 10) }    # id=1は"--"
    remarks              { Faker::Lorem.sentence }
    price                { Faker::Number.between(from: 0, to: 9_999_999) }
    income_date          { Faker::Date.between(from: 10.years.ago, to: Date.today) }
    association :user
  end
end
