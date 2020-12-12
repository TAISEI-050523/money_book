FactoryBot.define do
  factory :budget do
    house             { Faker::Number.between(from: 0, to: 9_999_999) }
    communications    { Faker::Number.between(from: 0, to: 9_999_999) }
    electricity       { Faker::Number.between(from: 0, to: 9_999_999) }
    gas               { Faker::Number.between(from: 0, to: 9_999_999) }
    water             { Faker::Number.between(from: 0, to: 9_999_999) }
    education         { Faker::Number.between(from: 0, to: 9_999_999) }
    premium           { Faker::Number.between(from: 0, to: 9_999_999) }
    lawn              { Faker::Number.between(from: 0, to: 9_999_999) }
    fixed_etcetera    { Faker::Number.between(from: 0, to: 9_999_999) }
    food              { Faker::Number.between(from: 0, to: 9_999_999) }
    commodity         { Faker::Number.between(from: 0, to: 9_999_999) }
    transportation    { Faker::Number.between(from: 0, to: 9_999_999) }
    hobby             { Faker::Number.between(from: 0, to: 9_999_999) }
    clothes           { Faker::Number.between(from: 0, to: 9_999_999) }
    health            { Faker::Number.between(from: 0, to: 9_999_999) }
    culture           { Faker::Number.between(from: 0, to: 9_999_999) }
    book              { Faker::Number.between(from: 0, to: 9_999_999) }
    cafe              { Faker::Number.between(from: 0, to: 9_999_999) }
    social            { Faker::Number.between(from: 0, to: 9_999_999) }
    special           { Faker::Number.between(from: 0, to: 9_999_999) }
    variable_etcetera { Faker::Number.between(from: 0, to: 9_999_999) }
    association :user
  end
end
