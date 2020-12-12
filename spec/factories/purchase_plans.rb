FactoryBot.define do
  factory :purchase_plan do
    name             { Faker::Number.between(from: 2, to: 10) }    # id=1は"--"
    remarks          { Faker::Lorem.sentence }
    price            { Faker::Number.between(from: 0, to: 9_999_999) }
    purchase_date    { Faker::Date.between(from: Date.today, to: Date.today.since(1.years)) }
    association :user

    after(:build) do |purchase_plan|
      purchase_plan.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end

  end
end
