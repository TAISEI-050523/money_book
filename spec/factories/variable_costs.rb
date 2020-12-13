FactoryBot.define do
  factory :variable_cost do
    variable_cost_category_id { Faker::Number.between(from: 2, to: 13) }    # id=1は"--"
    remarks                   { Faker::Lorem.sentence }
    price                     { Faker::Number.between(from: 0, to: 9_999_999) }
    expense_date              { Faker::Date.between(from: Date.today.years_ago(10), to: Date.today.years_since(5)) }
    association :user
  end
end
