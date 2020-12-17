FactoryBot.define do
  factory :budget do
    house             { Faker::Number.between(from: 0, to: 10_000_000) }
    communications    { Faker::Number.between(from: 0, to: 10_000_000) }
    electricity       { Faker::Number.between(from: 0, to: 10_000_000) }
    gas               { Faker::Number.between(from: 0, to: 10_000_000) }
    water             { Faker::Number.between(from: 0, to: 10_000_000) }
    education         { Faker::Number.between(from: 0, to: 10_000_000) }
    premium           { Faker::Number.between(from: 0, to: 10_000_000) }
    lawn              { Faker::Number.between(from: 0, to: 10_000_000) }
    fixed_etcetera    { Faker::Number.between(from: 0, to: 10_000_000) }
    food              { Faker::Number.between(from: 0, to: 10_000_000) }
    commodity         { Faker::Number.between(from: 0, to: 10_000_000) }
    transportation    { Faker::Number.between(from: 0, to: 10_000_000) }
    hobby             { Faker::Number.between(from: 0, to: 10_000_000) }
    clothes           { Faker::Number.between(from: 0, to: 10_000_000) }
    health            { Faker::Number.between(from: 0, to: 10_000_000) }
    culture           { Faker::Number.between(from: 0, to: 10_000_000) }
    book              { Faker::Number.between(from: 0, to: 10_000_000) }
    cafe              { Faker::Number.between(from: 0, to: 10_000_000) }
    social            { Faker::Number.between(from: 0, to: 10_000_000) }
    special           { Faker::Number.between(from: 0, to: 10_000_000) }
    variable_etcetera { Faker::Number.between(from: 0, to: 10_000_000) }
    association :user
  end
end
